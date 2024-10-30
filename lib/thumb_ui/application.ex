defmodule ThumbUi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ThumbUiWeb.Telemetry,
      ThumbUi.Repo,
      {DNSCluster, query: Application.get_env(:thumb_ui, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ThumbUi.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ThumbUi.Finch},
      # Start a worker by calling: ThumbUi.Worker.start_link(arg)
      # {ThumbUi.Worker, arg},
      # Start to serve requests, typically the last entry
      ThumbUiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ThumbUi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ThumbUiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
