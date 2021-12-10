defmodule Cash.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Cash.Repo,
      # Start the Telemetry supervisor
      CashWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Cash.PubSub},
      # Start the Endpoint (http/https)
      CashWeb.Endpoint
      # Start a worker by calling: Cash.Worker.start_link(arg)
      # {Cash.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Cash.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CashWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
