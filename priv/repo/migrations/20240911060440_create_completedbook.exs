defmodule BooksInventory.Repo.Migrations.CreateCompletedbook do
  use Ecto.Migration

  def change do
    alter table(:book) do
      add :completed, :boolean
    end


  end
end
