defmodule GraphCommons.Graph do

  ## ATTRIBUTES

  # START:attributes
  @storage_dir GraphCommons.storage_dir()
  # END:attributes

  ## STRUCT

  # START:derive
  @derive {Inspect, except: [:path, :uri]}
  # END:derive

  # START:defstruct
  @enforce_keys ~w[data file type]a
  defstruct ~w[data file path type uri]a
  # END:defstruct

  ## TYPES

  # START:types
  @type graph_data :: String.t()
  @type graph_file :: String.t()
  @type graph_path :: String.t()
  @type graph_type :: GraphCommons.graph_type()
  @type graph_uri :: String.t()

  @type t :: %__MODULE__{
          # user
          data: graph_data,
          file: graph_file,
          type: graph_type,
          # system
          path: graph_path,
          uri: graph_uri
        }
  # END:types

  # START:defguard
  defguard is_graph_type(graph_type)
           when graph_type in [ :dgraph, :native, :property, :rdf, :tinker ]
  # END:defguard

  ## CONSTRUCTOR

  # START:new
  def new(graph_data, graph_file, graph_type)
      when is_graph_type(graph_type) do
    graph_path = "#{@storage_dir}/#{graph_type}/graphs/#{graph_file}"

    %__MODULE__{
      # user
      data: graph_data,
      file: graph_file,
      type: graph_type,
      # system
      path: graph_path,
      uri: "file://" <> graph_path
    }
  end
  # END:new

  ## FUNCTIONS

  def graphs_dir(graph_type), do: "#{@storage_dir}/#{graph_type}/graphs/"

  # START:type_file_test
  @type file_test :: GraphCommons.file_test()
  # END:type_file_test

  # START:list_graphs
  def list_graphs(graph_type, file_test \\ :exists?) do
    list_graphs_dir("", graph_type, file_test)
  end
  # END:list_graphs

  # START:list_graphs_dir
  def list_graphs_dir(graph_file, graph_type, file_test \\ :exists?) do
    path = "#{@storage_dir}/#{graph_type}/graphs/"

    (path <> graph_file)
    |> File.ls!()
    |> do_filter(path, file_test)
    |> Enum.sort()
    |> Enum.map(fn f ->
      File.dir?(path <> f)
      |> case do
        true -> "#{String.upcase(f)}"
        false -> f
      end
    end)
  end
  # END:list_graphs_dir

  # START:do_filter
  defp do_filter(files, path, file_test) do
    files
    |> Enum.filter(fn f ->
      case file_test do
        :dir? -> File.dir?(path <> f)
        :regular? -> File.regular?(path <> f)
        :exists? -> true
      end
    end)
  end
  # END:do_filter

  # START:read_graph
  def read_graph(graph_file, graph_type)
      when graph_file != "" and is_graph_type(graph_type) do
    graphs_dir = "#{@storage_dir}/#{graph_type}/graphs/"
    graph_data = File.read!(graphs_dir <> graph_file)

    new(graph_data, graph_file, graph_type)
  end
  # END:read_graph

  # START:write_graph
  def write_graph(graph_data, graph_file, graph_type)
      when graph_data != "" and
             graph_file != "" and is_graph_type(graph_type) do
    graphs_dir = "#{@storage_dir}/#{graph_type}/graphs/"
    File.write!(graphs_dir <> graph_file, graph_data)

    new(graph_data, graph_file, graph_type)
  end
  # END:write_graph

  ## MACROS

  # START:defmacro
  defmacro __using__(opts) do
    graph_type = Keyword.get(opts, :graph_type)
    graph_module = Keyword.get(opts, :graph_module)

    quote do

      ## TYPES

       @type graph_file_test :: GraphCommons.file_test()

       @type graph_data :: GraphCommons.Graph.graph_data()
       @type graph_file :: GraphCommons.Graph.graph_file()
       @type graph_path :: GraphCommons.Graph.graph_path()
       @type graph_type :: GraphCommons.Graph.graph_type()
       @type graph_uri :: GraphCommons.Graph.graph_uri()

       @type graph_t :: GraphCommons.Graph.t()

       ## FUNCTIONS

       # START:graph_service
       def graph_service(), do: unquote(graph_module)
       # END:graph_service

       def list_graphs(graph_file_test \\ :exists?),
         do: GraphCommons.Graph.list_graphs(
           unquote(graph_type), graph_file_test)

       def list_graphs_dir(dir, graph_file_test \\ :exists?),
         do: GraphCommons.Graph.list_graphs_dir(dir,
           unquote(graph_type), graph_file_test)

       def new_graph(graph_data), do: new_graph(graph_data, "")

       def new_graph(graph_data, graph_file),
         do: GraphCommons.Graph.new(graph_data, graph_file,
           unquote(graph_type))

       def read_graph(graph_file),
         do: GraphCommons.Graph.read_graph(graph_file,
           unquote(graph_type))

       def write_graph(graph_data, graph_file),
         do: GraphCommons.Graph.write_graph(graph_data, graph_file,
           unquote(graph_type))
     end
  end
  # END:defmacro

  ## IMPLEMENTATIONS

  # START:inspect
  defimpl Inspect, for: __MODULE__ do
    @slice 16  # <label id="code.insp.graph.1"/>
    @quote <<?">>  # <label id="code.insp.graph.2"/>

    def inspect(%GraphCommons.Graph{} = graph, _opts) do
      type = graph.type
      file = @quote <> graph.file <> @quote

      str =
        graph.data
        |> String.replace("\n", "\\n")  # <label id="code.insp.graph.3"/>
        |> String.replace(@quote, "\\" <> @quote)  # <label id="code.insp.graph.4"/>
        |> String.slice(0, @slice)  # <label id="code.insp.graph.5"/>

      data =
        case String.length(str) < @slice do  # <label id="code.insp.graph.6"/>
          true -> @quote <> str <> @quote
          false -> @quote <> str <> "..." <> @quote
        end

      "#GraphCommons.Graph<type: #{type}, file: #{file}, data: #{data}>"  # <label id="code.insp.graph.7"/>
    end
  end
  # END:inspect

end
