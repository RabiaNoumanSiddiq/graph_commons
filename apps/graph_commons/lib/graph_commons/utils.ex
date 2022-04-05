defmodule GraphCommons.Utils do

  # START:is_module
  defguard is_module(graph_module)
    when graph_module in [DGraph, NativeGraph, PropertyGraph, RDFGraph,
    TinkerGraph]
  # END:is_module

  # START:graph_service
  defmacro graph_service(graph_module) do
    quote do
      # unimport any existing graph modules
      import DGraph, only: []
      import NativeGraph, only: []
      import PropertyGraph, only: []
      import RDFGraph, only: []
      import TinkerGraph, only: []
      # import graph module argument
      import unquote(graph_module)
    end
  end
  # END:graph_service

  defmacro gs(graph_module) do
    quote do
      graph_service(unquote(graph_module))
      graph_info()
    end
  end

  defmacro repeat(times, block) do
    quote do
      for _ <- 1..unquote(times), do: unquote(block)
    end
  end

  ## QUERY HELPERS

  # START:to_query_graph
  defp to_query_graph!(graph_module, query_string)
       when is_module(graph_module) do
    query_string
    |> graph_module.new_query()
    |> graph_module.query_graph!()
  end
  # END:to_query_graph

  defp to_query_graph!(graph_module, query_string, query_params)
       when is_module(graph_module) do
    query_string
    |> graph_module.new_query()
    |> graph_module.query_graph!(query_params)
  end

  defp to_query_graph(graph_module, query_string)
       when is_module(graph_module) do
    query_string
    |> graph_module.new_query()
    |> graph_module.query_graph()
  end

  # START:cypher_query
  def cypher!(query_string), do: to_query_graph!(PropertyGraph, query_string)
  # END:cypher_query

  # START:cypher_query_params
  def cypher!(query_string, query_params),
    do: to_query_graph!(PropertyGraph, query_string, query_params)
  # END:cypher_query_params

  # START:dgraph_query
  def dgraph!(query_string), do: to_query_graph(DGraph, query_string)
  # END:dgraph_query

  # START:gremlin_query
  def gremlin!(query_string), do: to_query_graph!(TinkerGraph, query_string)
  # `end`:gremlin_query

  # START:libgraph_query
  def libgraph!(query_string), do: to_query_graph!(NativeGraph, query_string)
  # END:libgraph_query

  # START:sparql_query
  def sparql!(query_string), do: to_query_graph!(RDFGraph, query_string)
  # END:sparql_query

  def sparql!(query_string, query_params),
    do: to_query_graph!(RDFGraph, query_string, query_params)

    @spec sparql!(String.t(), map()) :: any
    def sparql_update!(query_string, query_params \\ []),
      do: to_query_graph!(RDFGraph, query_string, Keyword.put(query_params, :update, true))

  def graph_modules do
    Enum.reduce(list_graph_modules(), [], fn m, acc ->
      acc ++ [{Application.get_application(m), m}]
    end)
  end

  # START:list_graph_modules
  @graph_modules [DGraph, NativeGraph, PropertyGraph, RDFGraph, TinkerGraph]
  def list_graph_modules, do: @graph_modules
  # END:list_graph_modules

  # START:list_apps
  def list_apps do
    list =
      Mix.Project.config()[:apps]
      |> case do
        nil -> [Mix.Project.config()[:app]]
        _ -> Mix.Project.config()[:apps]
      end

    IO.puts(inspect(list, limit: :infinity, pretty: true))
  end
  # END:list_apps

  # START:list_modules
  def list_modules(app) do
    {:ok, list} = :application.get_key(app, :modules)
    IO.puts(inspect(list, limit: :infinity, pretty: true))
  end
  # END:list_modules

  # START:list_functions
  def list_functions(module) do
    # function_exported?(module, :__info__, 1)
    list = module.__info__(:functions)
    IO.puts(inspect(list, limit: :infinity, pretty: true))
  end
  # END:list_functions

  def list_macros(module) do
    # function_exported?(module, :__info__, 1)
    list = module.__info__(:macros)
    IO.puts(inspect(list, limit: :infinity, pretty: true))
  end

  # START:help0
  def help(), do: list_apps()
  # END:help0

  # START:help1
  def help(arg) when is_atom(arg) do
    arg
    |> :application.get_key(:modules)
    |> case do
      {:ok, _} ->
        list_modules(arg)

      :undefined ->
        Code.ensure_loaded(arg)

        arg
        |> function_exported?(:__info__, 1)
        |> case do
          true -> list_functions(arg)
          false -> raise "! Unknown arg: #{arg}"
        end
    end
  end
  # END:help1

end
