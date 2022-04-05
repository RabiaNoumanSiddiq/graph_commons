defmodule NativeGraph.Serializers.Edgelist do
  use NativeGraph.Serializer
  alias NativeGraph.Serializer

  def serialize(g) do
    result = "#{serialize_edges(g)}\n"

    {:ok, result}
  end

  def serialize_edges(%Graph{vertices: vertices, out_edges: oe} = g) do
    Enum.reduce(vertices, [], fn {id, v}, acc ->
      v_label = Serializer.get_vertex_label(g, id, v)

      edges =
        oe
        |> Map.get(id, MapSet.new())
        |> Enum.map(fn id2 ->
          v2_label = Serializer.get_vertex_label(g, id2, Map.get(vertices, id2))
          {v_label, v2_label}
        end)

      case edges do
        [] -> acc
        _ -> acc ++ edges
      end
    end)
    |> Enum.map(fn {v_label, v2_label} -> "#{v_label} #{v2_label}" end)
    |> Enum.join("\n")
  end
  
end
