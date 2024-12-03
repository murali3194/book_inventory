defmodule BooksInventory.Book do
  use Ecto.Schema

  schema "book" do
    field :name, :string
    field :author, :string
    field :completed, :boolean, default: :false
    has_one :remark, BooksInventory.Remark
  end

  def changeset(book, params \\ %{}) do
    book
    |> Ecto.Changeset.cast(params, [:name, :author, :completed])
    |> Ecto.Changeset.validate_required([:name, :author, :completed])

  end


end
