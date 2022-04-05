defmodule PropertyGraph.Application do
  use Application

  def start(_type, _args) do
    children = [
      # START_HIGHLIGHT
      {Bolt.Sips, Application.get_env(:bolt_sips, Bolt)}
      # END_HIGHLIGHT
    ]

    # START_HIGHLIGHT
    opts = [strategy: :one_for_one, name: PropertyGraph.Service]
    # END_HIGHLIGHT
    Supervisor.start_link(children, opts)
  end

end
