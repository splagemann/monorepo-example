defmodule FirstElixirApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :first_elixir_app,
      version: "0.1.0",
      elixir: ">= 1.5.2",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:excoveralls, "~> 0.7", only: :test}
    ]
  end
end
