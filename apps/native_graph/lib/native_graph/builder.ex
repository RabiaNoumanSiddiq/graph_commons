defmodule NativeGraph.Builder do
  require Integer

  ## FUNCTIONS

  # START:random_graph
  def random_graph(limit) do
    for(n <- 1..limit, m <- (n + 1)..limit, do: do_evaluate(n, m))
    |> Enum.reject(&is_nil/1)
    |> Enum.reduce(
      Graph.new(),
      fn [rs, re], g ->
        Graph.add_edge(g, rs, re)
      end
    )
  end
  # END:random_graph

  # START:do_evaluate
  defp do_evaluate(n, m) do
    case Integer.is_even(Kernel.trunc(System.os_time() / 1000)) do
      true -> [n, m]
      false -> nil
    end
  end
  # END:do_evaluate

end
