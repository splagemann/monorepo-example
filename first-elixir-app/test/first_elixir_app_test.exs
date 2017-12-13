defmodule FirstElixirAppTest do
  use ExUnit.Case
  doctest FirstElixirApp

  test "greets the world" do
    assert FirstElixirApp.hello() == :world
  end
end
