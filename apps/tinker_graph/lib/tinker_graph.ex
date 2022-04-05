defmodule TinkerGraph do

  ## GRAPH STORE

  use GraphCommons.Graph, graph_type: :tinker, graph_module: __MODULE__
  use GraphCommons.Query, query_type: :tinker, query_module: __MODULE__

  ## GRAPH SERVICE

  defdelegate graph_create(arg), to: TinkerGraph.Service, as: :graph_create
  defdelegate graph_delete(), to: TinkerGraph.Service, as: :graph_delete
  defdelegate graph_info(), to: TinkerGraph.Service, as: :graph_info
  # defdelegate graph_read(), to: TinkerGraph.Service, as: :graph_read
  defdelegate graph_update(arg), to: TinkerGraph.Service, as: :graph_update

  defdelegate query_graph(arg), to: TinkerGraph.Service, as: :query_graph
  defdelegate query_graph!(arg), to: TinkerGraph.Service, as: :query_graph!

end
