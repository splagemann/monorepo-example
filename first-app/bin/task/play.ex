defmodule SwitchBoard.Task.Play do
  use SwitchBoard.Task, url: "", loop: "1"

  def perform(_call, %__struct__{state: :pending, url: url, loop: loop} = task, _params) do
    task = %{task | state: :delivered}
    {task, ~s(<Play loop="#{loop}">#{url}</Play>)}
  end
end
