defmodule PropertyGraph.MixProject do
  use Mix.Project

  def project do
    [
      app: :property_graph,
      version: "0.1.0",
      description: "ExGraphsBook - Property graph functions.",
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
  # START:application
  def application do
    [
      extra_applications: [:logger],
      # START_HIGHLIGHT
      mod: {PropertyGraph.Application, []}
      # END_HIGHLIGHT
    ]
  end
  # END:application

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # graph_commons
      {:graph_commons, in_umbrella: true},

      # property graphs
      {:bolt_sips, "~> 2.0"}
    ]
  end
end
