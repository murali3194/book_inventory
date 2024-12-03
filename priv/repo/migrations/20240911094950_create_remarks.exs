defmodule BooksInventory.Repo.Migrations.CreateRemarks do
  use Ecto.Migration

  def change do
    create table(:remarks) do
      add :learning, :text
      add :overallsatisfactory, :string
      add :book_id, references(:book, on_delete: :delete_all)
    end

  end
end
