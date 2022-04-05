defmodule GraphCompute.Process do
  use GenServer

  # START:constructor
  def start_link(opts \\ []) do
    case GenServer.start_link(__MODULE__, opts) do
      {:ok, pid} -> {:ok, pid}
      {:error, reason} -> {:error, reason}
    end
  end
  # END:constructor

  ## API

  # START:calls
  def get(pid) do
    GenServer.call(pid, {:get})
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end

  def put(pid, key, value) do
    GenServer.cast(pid, {:put, key, value})
  end
  # END:calls

  ## Callbacks

  # START:init
  @impl true
  def init(_), do: do_init()

  @impl true
  def terminate(_reason, state), do: do_terminate(state)
  # END:init

  # START:init_defp
  defp do_init() do
    Process.flag(:trap_exit, true)

    state = GraphCompute.State.get()
    new_pid = self()
    old_pid = Map.get(state, :pid)
    state = Map.put(state, :pid, new_pid)
    state = Map.put(state, :old_pid, old_pid)

    # START_HIGHLIGHT
    with %Graph{} = graph <- GraphCompute.Graph.get() do
    # END_HIGHLIGHT
        GraphCompute.Graph.update(
            Graph.replace_vertex(graph, old_pid, new_pid)
        )
    end

    {:ok, state}
  end
  # END:init_defp

  # START:terminate_defp
  defp do_terminate(state) do
    GraphCompute.State.update(state)
  end
  # END:terminate_defp

  # START:callbacks
  @impl true
  def handle_call({:get}, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_call({:get, key}, _from, state) do
    {:reply, Map.fetch!(state, key), state}
  end

  @impl true
  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end
  # END:callbacks

  # START:handle_info
  @impl true
  def handle_info(_reason, state) do
     {:stop, :normal, state}
  end
  # END:handle_info

end
