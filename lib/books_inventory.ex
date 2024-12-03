defmodule BooksInventory do
  alias BooksInventory.{Book, Remark}
  alias BooksInventory.Repo
  @moduledoc """
  BooksInventory keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def start() do
   options =  IO.gets("Enter the Following \n 1. Create a book \n 2. list a book \n 3. Update a book\n 4. Delete a Book \n 5. Add remarks \n 6. Remark list\n 7. Exit") |> String.trim_trailing() |> String.to_integer()

   case options do
     1 -> create_book()
          start()

     2 -> list_books()
          start()

     3 -> update_reading_status()
          start()

     4 -> delete_the_book()
          start()

     5 -> add_remark_for_a_book()
          start()

     6 -> list_inventory_with_remarks()
          start()

      _ -> IO.puts "Good bye"
   end


  end


  def create_book do
    name = IO.gets("Enter the Book name\n") |> String.trim_trailing()
    author = IO.gets("Enter the #{name}'s author\n") |> String.trim_trailing()
    finished = IO.gets("Enter the book finished reading? yes or no\n") |> String.trim_trailing()
    book = %Book{name: name, author: author, completed: finished == "yes"}
    changeset = Book.changeset(book)
    case Repo.insert(changeset) do
      {:ok, _book} -> IO.puts "The #{name} Book is Successfully inserted"
                      list_books()

      {:error, _} -> IO.puts  "Please enter proper values"
                    create_book()

    end
  end

  def list_books do
    books = Repo.all(Book)
    IO.puts "------------------------------------------------------"
    Enum.each(books, fn book -> IO.puts "#{book.id} #{book.name} by #{book.author}- completed: #{book.completed}" end)
    IO.puts "------------------------------------------------------"
  end

  def list_inventory_with_remarks() do
    books = Repo.all(Book) |> Repo.preload(:remark)
    IO.puts "------------------------------------------------------"
    IO.puts "ID\t Name\t Author\t Completed\t Learning\t OverallSatisfactory\t Boo_id\t"
    Enum.each(books, fn book ->

       IO.puts "#{book.id}\t #{book.name}\t  #{book.author}\t #{book.completed}\t "
       if book.remark do
       IO.puts " #{book.remark.learning}\t #{book.remark.overallsatisfactory}\t #{book.remark.book_id}\t"
       end
    end)
    IO.puts "------------------------------------------------------"
  end

  def update_reading_status do
    books = list_books()
    IO.puts "Listing the books"
    IO.inspect(books)
    id = IO.gets("Entert the corresponding id to update the reading status\n") |> String.trim_trailing() |> String.to_integer()
    case Repo.get(Book, id) do
      book -> status = IO.gets("Enter the corrsponding reading status ? yes or no \n") |> String.trim_trailing()
               IO.puts "status is #{status}"
               IO.inspect({:books, book})
               changeset =  Book.changeset(book, %{completed: status == "yes"})
                case Repo.update(changeset) do
                  {:ok, book} -> IO.puts "Book #{book.name} reading status is updated successfully"
                                 list_books()
                  {:error, _} -> IO.puts  "Please enter proper values"
                                update_reading_status()
                end
    end

  end


  def delete_the_book do
    books = list_books()
    IO.puts "Listing the books"
    IO.inspect(books)
    id = IO.gets("Enter the corresponding id to Delete the book\n") |> String.trim_trailing() |> String.to_integer()
    book =  Repo.get!(Book, id)
    case Repo.delete(book) do
      {:ok, book} -> IO.puts "the corresponding book #{book.name} is Deleted"
                    list_books()
      {:error, _ } -> IO.puts  "Please enter proper values"
                      delete_the_book()
    end
  end

  def add_remark_for_a_book() do
    book = list_books()
    IO.puts "Listing the books"
    IO.inspect(book)
    if !book.completed do
      IO.puts("Warning The Book Reading is not completed\n")
    end
    id = IO.gets("Enter the corresponding id of the book\n ") |> String.trim_trailing() |> String.to_integer()
    book = Repo.get(Book, id)
    learnings = IO.gets("Enter the learning from #{book.name}\n") |> String.trim_trailing()
    overallsatisfactory = IO.gets("Enter the Overallsatisfactory good or bad\n") |> String.trim_trailing()
    remark = %Remark{learning: learnings, overallsatisfactory: overallsatisfactory, book_id: id}
    changeset = Ecto.Changeset.change(remark, %{})
    case Repo.insert(changeset) do
      {:ok, remark} -> IO.puts "Remark insertered Successfully, Satisfied #{remark.overallsatisfactory}"

      {:error, _} -> IO.puts  "Please enter proper values"
                      add_remark_for_a_book()
    end
  end


end
