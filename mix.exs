defmodule ExAdvent.MixProject do
  use Mix.Project

  def project do
    [
      app: :advent_2024,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:scribe, "~> 0.11"},
      {:nimble_parsec, "~> 1.4"}
    ]
  end
end
