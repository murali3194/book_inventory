defmodule BooksInventory.Remark do
  use Ecto.Schema

  schema "remarks" do
    field :learning, :string
    field :overallsatisfactory, :string
    belongs_to :book, BooksInventory.Book
  end

  def changeset(remark, params \\ %{}) do
    remark
    |> Ecto.Changeset.cast(params, [:learnings, :overallsatisfactory, :book_id])
    |> Ecto.Changeset.validate_required([:learnings, :overallsatisfactory, :book_id])
  end

end
