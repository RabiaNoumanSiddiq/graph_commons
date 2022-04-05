defmodule PropertyGraph do

  ## GRAPH STORE

  use GraphCommons.Graph, graph_type: :property, graph_module: __MODULE__
  use GraphCommons.Query, query_type: :property, query_module: __MODULE__

  ## GRAPH SERVICE

  defdelegate graph_create(arg), to: PropertyGraph.Service, as: :graph_create
  defdelegate graph_delete(), to: PropertyGraph.Service, as: :graph_delete
  defdelegate graph_info(), to: PropertyGraph.Service, as: :graph_info
  defdelegate graph_read(), to: PropertyGraph.Service, as: :graph_read
  defdelegate graph_update(arg), to: PropertyGraph.Service, as: :graph_update

  defdelegate query_graph(arg), to: PropertyGraph.Service, as: :query_graph
  defdelegate query_graph!(arg), to: PropertyGraph.Service, as: :query_graph!

  defdelegate query_graph(arg, params), to: PropertyGraph.Service, as: :query_graph
  defdelegate query_graph!(arg, params), to: PropertyGraph.Service, as: :query_graph!

end
