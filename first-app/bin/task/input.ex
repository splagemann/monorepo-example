defmodule SwitchBoard.Task.Input do
  require Logger

  use SwitchBoard.Task,
    async: true,
    result: "",
    unstable_result: "",
    voice: "Joanna",
    language: "en-US"

  alias SwitchBoard.Helper.Twilio

  # perform

  def perform(call, %__struct__{state: :pending} = task, _params) do
    task = %{task | state: :processing}

    {
      task,
      ~s(
      <Gather
        input="speech"
        action="/calls/#{call.id}/tasks/#{task.id}"
        partialResultCallback="/calls/#{call.id}/tasks/#{task.id}"
        timeout="2"
        language="#{task.language}"
      >
        <Pause length="6" />
      </Gather>
      <Redirect />
      )
    }
  end

  def perform(_call, %__struct__{state: :processing} = task, _params) do
    {task, ~s(<Redirect />)}
  end

  def perform(_call, %__struct__{state: :processed} = task, _params) do
    task = %{task | state: :delivered}

    {
      task,
      Twilio.say(%{text: "You said: #{task.result}", voice: task.voice, language: task.language})
    }
  end

  # update

  def update(call, task, conn), do: update(call, task, conn, conn.params)

  defp update(_call, task, conn, %{"UnstableSpeechResult" => unstable_result}) do
    Logger.debug("UnstableSpeechResult #{unstable_result}")

    task = %{task | unstable_result: unstable_result}

    {task, conn |> resp(200, "")}
  end

  defp update(_call, task, conn, %{"SpeechResult" => result}) do
    task = %{task | state: :processed, result: result}

    conn =
      conn
      |> put_resp_content_type("application/xml")
      |> resp(200, ~S(<Response><Redirect>/twilio/call</Redirect></Response>))

    {task, conn}
  end

  defp update(_call, task, conn, params) do
    Logger.warn("Unexpected request #{inspect(params)}")

    task = %{task | state: :failed}

    conn =
      conn
      |> put_resp_content_type("application/xml")
      |> resp(200, ~S(<Response><Redirect>/twilio/call</Redirect></Response>))

    {task, conn}
  end
end
