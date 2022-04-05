defmodule NativeGraph.Utils do

  defp from_edgelist_(edgelist, type \\ :undirected)
       when type in [:directed, :undirected] do
    g = Graph.new(type: type)

    edgelist
    |> Enum.reduce(
      g,
      fn edge, g ->
        # match relationship
        {rs, re} = edge

        # build graph
        g
        |> Graph.add_edge(rs, re)
      end
    )
  end

  def from_edgelist(edgelist, type \\ :undirected)
      when type in [:directed, :undirected] do
    g = Graph.new(type: type)

    edgelist
    |> Enum.reduce(g, fn {rs, re}, g -> Graph.add_edge(g, rs, re) end)
  end

  def from_edgelist_file(edgelist_file, type \\ :undirected)
      when type in [:directed, :undirected] do
    g = Graph.new(type: type)

    g =
      File.stream!(edgelist_file)
      |> Enum.map(&(String.trim(&1)))
      |> Enum.reject(&(String.starts_with?(&1, "#")))
      |> Enum.reduce(g, fn s, g -> parse_line(s, g) end)

    g
  end

  defp parse_line(s, g) do
    [rs, re] = Regex.split(~r{\s+}, s)
    Graph.add_edge(g, rs, re)
  end

  def to_graph(%Graph{} = g, type \\ :undirected)
      when type in [:directed, :undirected] do
    s = "Graph.new(type: #{inspect type})\n"

    g
    |> Graph.edges()
    |> Enum.reduce(
      s,
      fn e, s ->
        s <> "|> Graph.add_edge(#{inspect(e.v1)}, #{inspect(e.v2)}, label: \"#{e.label}\")\n"
      end
    )
  end

  def to_graph_pid(%Graph{} = g, type \\ :undirected)
    when type in [:directed, :undirected] do
     g
     |> to_graph(type)
     |> String.replace(~r/#PID<([^>]+)>/, "IEx.Helpers.pid(\"\\1\")")
  end

end
