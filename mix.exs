defmodule ElixirSecurityAdvisories.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_security_advisories,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:jason, "~> 1.3.0"},
      {:tesla, "~> 1.4.0"},
      {:ymlr, "~> 3.0"}
    ]
  end
end
