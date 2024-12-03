defmodule BooksInventory.Repo.Migrations.CreateBook do
  use Ecto.Migration

  def change do
    create table(:book) do
      add :name, :string
      add :author, :string

    end
  end
end
