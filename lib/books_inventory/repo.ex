defmodule BooksInventory.Repo do
  use Ecto.Repo,
    otp_app: :books_inventory,
    adapter: Ecto.Adapters.SQLite3
end
