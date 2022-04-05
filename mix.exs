defmodule ExGraphsBook.MixProject do
  use Mix.Project

  # START:project
  def project do
    [
      aliases: aliases(),  # <label id="code.mix.project.1"/>
      apps: [  # <label id="code.mix.project.2"/>
        :d_graph,
        :graph_commons,
        :graph_compute,
        :native_graph,
        :property_graph,
        :rdf_graph,
        :tinker_graph
      ],
      apps_path: "apps",
      deps: deps(),
      docs: [  # <label id="code.mix.project.3"/>
        main: "readme",
        extras: ["README.md"]
      ],
      start_permanent: Mix.env() == :prod
    ]
  end
  # END:project

  defp deps do
    [
      {:inch_ex, github: "rrrene/inch_ex", only: [:dev, :test]},
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false}
    ]
  end

  defp aliases do
    [
      test_d_graph: "cmd --app d_graph mix test --color",
      test_graph_commons: "cmd --app graph_commons mix test --color",
      test_graph_compute: "cmd --app graph_compute mix test --color",
      test_native_graph: "cmd --app native_graph mix test --color",
      test_property_graph: "cmd --app property_graph mix test --color",
      test_rdf_graph: "cmd --app rdf_graph mix test --color",
      test_tinker_graph: "cmd --app tinker_graph mix test --color"
    ]
  end
end
