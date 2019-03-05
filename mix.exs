defmodule JoseError.MixProject do
  use Mix.Project

  def project do
    [
      app: :jose_error,
      version: "0.1.0",
      elixir: "~> 1.8",
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
      # when using this version the test fail
      {:jose, "~> 1.9"},
      # when using this version the test pass
      # {:jose, "< 1.9.0"},
      {:poison, "~> 3.1"}
    ]
  end
end
