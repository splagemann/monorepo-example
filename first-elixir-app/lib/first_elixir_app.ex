defmodule FirstElixirApp do
  @moduledoc """
  Documentation for FirstElixirApp.
  """

  @doc """
  Hello world.

  ## Examples

      iex> FirstElixirApp.hello
      :world

  """
  def hello do
    do_something_meaningful()
    :world
  end

  def uncovered_function do
    :timer.sleep(1000)
  end

  defp do_something_meaningful do
    :timer.sleep(1000)
  end
end
