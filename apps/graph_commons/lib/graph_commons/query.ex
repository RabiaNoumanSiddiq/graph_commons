defmodule GraphCommons.Query do

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
  @type query_data :: String.t()
  @type query_file :: String.t()
  @type query_path :: String.t()
  @type query_type :: GraphCommons.query_type()
  @type query_uri :: String.t()

  @type t :: %__MODULE__{
          # user
          data: query_data,
          file: query_file,
          type: query_type,
          # system
          path: query_path,
          uri: query_uri
        }
  # END:types

  # START:defguard
  defguard is_query_type(query_type)
           when query_type in [ :dgraph, :native, :property, :rdf, :tinker ]
  # END:defguard

  ## CONSTRUCTOR

  # START:new
  def new(query_data, query_file, query_type)
      when is_query_type(query_type) do
    query_path = "#{@storage_dir}/#{query_type}/queries/#{query_file}"

    %__MODULE__{
      # user
      data: query_data,
      file: query_file,
      type: query_type,
      # system
      path: query_path,
      uri: "file://" <> query_path
    }
  end
  # END:new

  ## FUNCTIONS

  def queries_dir(query_type), do: "#{@storage_dir}/#{query_type}/queries/"

  # START:type_file_test
  @type file_test :: GraphCommons.file_test()
  # END:type_file_test

  # START:list_queries
  def list_queries(query_type, file_test \\ :exists?) do
    list_queries_dir("", query_type, file_test)
  end
  # END:list_queries

  # START:list_queries_dir
  def list_queries_dir(query_file, query_type, file_test \\ :exists?) do
    path = "#{@storage_dir}/#{query_type}/queries/"

    (path <> query_file)
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
  # END:list_queries_dir

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

  # START:read_query
  def read_query(query_file, query_type)
      when query_file != "" and is_query_type(query_type) do
    queries_dir = "#{@storage_dir}/#{query_type}/queries/"
    query_data = File.read!(queries_dir <> query_file)

    new(query_data, query_file, query_type)
  end
  # END:read_query

  # START:write_query
  def write_query(query_data, query_file, query_type)
      when query_data != "" and
             query_file != "" and is_query_type(query_type) do
    queries_dir = "#{@storage_dir}/#{query_type}/queries/"
    File.write!(queries_dir <> query_file, query_data)

    new(query_data, query_file, query_type)
  end
  # END:write_query

  ## MACROS

  # START:defmacro
  defmacro __using__(opts) do
    query_type = Keyword.get(opts, :query_type)
    # query_module = Keyword.get(opts, :query_module)

    quote do

      ## TYPES

      @type query_file_test :: GraphCommons.file_test()

      @type query_data :: GraphCommons.Query.query_data()
      @type query_file :: GraphCommons.Query.query_file()
      @type query_path :: GraphCommons.Query.query_path()
      @type query_type :: GraphCommons.Query.query_type()
      @type query_uri :: GraphCommons.Query.query_uri()

      @type query_t :: GraphCommons.Query.t()

      ## FUNCTIONS

      # # START:graph_service
      # def graph_service(), do: unquote(graph_module)
      # # END:graph_service

      def list_queries(query_file_test \\ :exists?),
        do: GraphCommons.Query.list_queries(
          unquote(query_type), query_file_test)

      def list_queries_dir(dir, query_file_test \\ :exists?),
        do: GraphCommons.Query.list_queries_dir(dir,
          unquote(query_type), query_file_test)

      def new_query(query_data), do: new_query(query_data, "")

      def new_query(query_data, query_file),
        do: GraphCommons.Query.new(query_data, query_file,
          unquote(query_type))

      def read_query(query_file),
        do: GraphCommons.Query.read_query(query_file,
          unquote(query_type))

      def write_query(query_data, query_file),
        do: GraphCommons.Query.write_query(query_data, query_file,
          unquote(query_type))
    end
  end
  # END:defmacro

  ## IMPLEMENTATIONS

  # START:inspect
  defimpl Inspect, for: __MODULE__ do
    @slice 16
    @quote <<?">>

    def inspect(%GraphCommons.Query{} = query, _opts) do
      type = query.type
      file = @quote <> query.file <> @quote

      str =
        query.data
        |> String.replace("\n", "\\n")
        |> String.replace(@quote, "\\" <> @quote)
        |> String.slice(0, @slice)

      data =
        case String.length(str) < @slice do
          true -> @quote <> str <> @quote
          false -> @quote <> str <> "..." <> @quote
        end

      "#GraphCommons.Query<type: #{type}, file: #{file}, data: #{data}>"
    end
  end
  # END:inspect

end
