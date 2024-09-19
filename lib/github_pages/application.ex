defmodule GithubPages.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GithubPagesWeb.Telemetry,
      GithubPages.Repo,
      {DNSCluster, query: Application.get_env(:github_pages, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: GithubPages.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: GithubPages.Finch},
      # Start a worker by calling: GithubPages.Worker.start_link(arg)
      # {GithubPages.Worker, arg},
      # Start to serve requests, typically the last entry
      GithubPagesWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GithubPages.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GithubPagesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
