defmodule GraphCommons do

  ## ATTRIBUTES

  # START:attributes
  @priv_dir "#{:code.priv_dir(:graph_commons)}"
  # END:attributes

  ## TYPES

  # START:types
  @typedoc "Types for graph storage."
  @type base_type :: :dgraph | :native | :property | :rdf | :tinker
  @type graph_type :: base_type()
  @type query_type :: base_type()

  @typedoc "Type for testing file types."
  @type file_test :: :dir? | :regular? | :exists?
  # END:types

  ## FUNCTIONS

  def exports_dir(), do: @priv_dir <> "/transfer/exports"
  def imports_dir(), do: @priv_dir <> "/transfer/imports"
  def scripts_dir(), do: @priv_dir <> "/extras/scripts"
  def storage_dir(), do: @priv_dir <> "/storage"

  # START:hello
  def hello do
    IO.puts("This is ExGraphsBook - an Elixir umbrella app:\n")
    GraphCommons.Utils.list_apps()
  end
  # END:hello

end
