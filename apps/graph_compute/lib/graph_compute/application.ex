defmodule GraphCompute.Application do
  use Application

  # START:application
  def start(type, args) do
    do_dynamic_supervisor(type, args)
    do_static_supervisor(type, args)
  end

  defp do_dynamic_supervisor(_type, _args) do
    opts = [
      name: GraphCompute.DynamicSupervisor,
      strategy: :one_for_one
    ]
    DynamicSupervisor.start_link(opts)
  end

  defp do_static_supervisor(_type, _args) do
    children = [
      {GraphCompute.Graph, %{}},
      {GraphCompute.State, %{}}
    ]
    opts = [
      name: GraphCompute.Supervisor,
      strategy: :one_for_one
    ]
    Supervisor.start_link(children, opts)
  end
  # END:application

  # START:genserver
  def genserver() do
    case DynamicSupervisor.start_child(
        GraphCompute.DynamicSupervisor, GraphCompute.Process
      ) do
      {:ok, pid} ->
        pid
      {:error, reason} ->
        IO.puts "! Error: #{inspect reason}"
    end
  end
  # END:genserver

end
