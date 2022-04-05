defmodule GraphCommons.MixProject do
  use Mix.Project

  def project do
    [
      umbrella_apps: "../../apps",
      app: :graph_commons,
      version: "0.1.0",
      description: "ExGraphsBook - Common graph functions.",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      #elixir: "~> 1.10",
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
  # START:deps
  defp deps do
    [
      {:ex_doc, "~> 0.24", only: :dev, runtime: false}
    ]
  end
  # END:deps

end
