defmodule BooksInventory.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BooksInventoryWeb.Telemetry,
      # Start the Ecto repository
      BooksInventory.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: BooksInventory.PubSub},
      # Start Finch
      {Finch, name: BooksInventory.Finch},
      # Start the Endpoint (http/https)
      BooksInventoryWeb.Endpoint
      # Start a worker by calling: BooksInventory.Worker.start_link(arg)
      # {BooksInventory.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BooksInventory.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BooksInventoryWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
