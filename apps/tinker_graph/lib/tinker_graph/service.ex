defmodule TinkerGraph.Service do
  @behaviour GraphCommons.Service
  # import GraphCommons.Utils, only: [eval: 1]

  ## GRAPH

  # START:graph_api
  def graph_create(graph) do
    graph_delete()
    graph_update(graph)
  end

  def graph_delete() do
    Gremlex.Client.query("g.V().drop()")
  end

  def graph_read() do
  end

  def graph_update(%GraphCommons.Graph{type: :tinker} = graph) do
    Gremlex.Client.query(graph.data)
  end
  # END:graph_api

  ## INFO

  # START:graph_info
  def graph_info() do
    {:ok, [num_vertices]} = Gremlex.Client.query("g.V().count()")
    {:ok, vertex_labels} = Gremlex.Client.query("g.V().label().dedup()")
    {:ok, [num_edges]} = Gremlex.Client.query("g.E().count()")
    {:ok, edge_labels} = Gremlex.Client.query("g.E().label().dedup()")

    %GraphCommons.Service.GraphInfo{
      type: :tinker,
      num_nodes: num_vertices,
      num_edges: num_edges,
      labels: vertex_labels ++ edge_labels
    }
  end
  # END:graph_info

  ## QUERY

  # START:graph_query
  def query_graph(%GraphCommons.Query{type: :tinker} = query) do
    Gremlex.Client.query(query.data)
  end

  def query_graph!(%GraphCommons.Query{type: :tinker} = query) do
    Gremlex.Client.query(query.data)
    |>
    case do
      {:ok, response} -> response
      {:error, message} -> raise "! #{message}"
    end
  end
  # END:graph_query

end
