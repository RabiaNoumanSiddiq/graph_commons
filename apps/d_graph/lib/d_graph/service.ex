defmodule DGraph.Service do
  @behaviour GraphCommons.Service
  # import GraphCommons.Utils, only: [eval: 1]

  # START:get_pid
  def get_pid() do
     Application.get_env(:dlex, PID)
  end
  # END:get_pid

  ## GRAPH

  # START:graph_api
  def graph_create(graph) do
    graph_delete()
    graph_update(graph)
  end

  def graph_delete() do
    Dlex.alter!(DGraph.Service.get_pid(), %{drop_all: true})
  end

  def graph_read() do
    # TBD
  end

  def graph_update(%GraphCommons.Graph{} = graph) do
    Dlex.mutate(DGraph.Service.get_pid(), %{set: graph.data})
  end
  # END:graph_api

  # START:graph_info
  def graph_info() do
    %GraphCommons.Service.GraphInfo{
      type: :dgraph,
      # num_nodes: num_vertices,
      # num_edges: num_edges,
      # labels: vertex_labels ++ edge_labels
    }
  end
  # END:graph_info

  # START:schema_update
  def schema_update(%GraphCommons.Graph{} = graph) do
    Dlex.alter(DGraph.Service.get_pid(), graph.data)
  end
  # END:schema_update

  ## QUERY

  # START:graph_query
  def query_graph(%GraphCommons.Query{} = query) do
    :dgraph = query.type

    Dlex.query(DGraph.Service.get_pid(), query.data)
    |> case do
      {:ok, response} -> response
      {:error, error} -> raise "! #{inspect error}"
    end
  end

  def query_graph!(%GraphCommons.Query{} = query) do
    :dgraph = query.type

    Dlex.query(DGraph.Service.get_pid(), query.data)
    |> case do
      {:ok, response} -> response
      {:error, error} -> raise "! #{inspect error}"
    end
  end
  # END:graph_query

end
