defmodule NativeGraph.Format do

  # START:to_png
  @graph_images_dir GraphCommons.storage_dir() <> "/native/graphs/images/"
  @binary_dir "/usr/local/bin"

  @type layout :: :dot | :neato | :twopi | :circo | :fdp | :sfdp |
                  :patchwork | :osage

  def to_png(%GraphCommons.Graph{} = graph, layout \\ :dot) do
    layout_cmd = Path.join(@binary_dir, Atom.to_string(layout))

    dot_file = graph.path
    png_file = @graph_images_dir <> Path.basename(dot_file, ".dot") <> ".png"

    with {_, 0} <-
           System.cmd(layout_cmd, ["-T", "png", dot_file, "-o", png_file]) do
      {:ok, Path.basename(png_file)}
      # else
      #   _ -> {:error, "! Error"}
    end
  end
  # END:to_png

  def dot_deps_to_exs(dot_file) do
    {:ok, dot} = File.read(dot_file)

    dg =
      [~s/Graph.new()\n/] ++
        (dot
         |> String.split("\n", trim: true)
         |> Enum.filter(fn s -> String.contains?(s, " -> ") end)
         |> Enum.map(fn
           s ->
             [_, x, _, y, _, z, _] = String.split(s, <<34>>)
             ~s/|> Graph.add_edge(:#{x}, :#{y}, label: "#{z}")\n/
         end))

    exs_file = Path.join(Path.dirname(dot_file), Path.basename(dot_file, ".dot") <> ".exs")
    File.write(exs_file, dg)
    IO.puts(exs_file)
  end

end
