defmodule SynacorChallenge.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the PubSub system
      {Phoenix.PubSub, name: SynacorChallenge.PubSub},
      # Start a worker by calling: SynacorChallenge.Worker.start_link(arg)
      {SynacorChallenge.VirtualMachine, program: File.read!("assets/challenge.bin"), name: ChallengeVirtualMachine}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: SynacorChallenge.Supervisor)
  end
end
