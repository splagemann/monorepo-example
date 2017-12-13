defmodule SwitchBoard.Task.Say do
  alias SwitchBoard.Helper.Twilio
  use SwitchBoard.Task, text: "", voice: "Joanna", language: "en-US"

  def perform(_call, %__struct__{state: :pending, text: text} = task, _params) do
    task = %{task | state: :delivered}
    {task, Twilio.say(%{text: text, voice: task.voice, language: task.language})}
  end
end
