defmodule PhoenixAuth.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PhoenixAuthWeb.Telemetry,
      # Start the Ecto repository
      PhoenixAuth.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: PhoenixAuth.PubSub},
      # Start Finch
      {Finch, name: PhoenixAuth.Finch},
      # Start the Endpoint (http/https)
      PhoenixAuthWeb.Endpoint
      # Start a worker by calling: PhoenixAuth.Worker.start_link(arg)
      # {PhoenixAuth.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixAuth.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixAuthWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
