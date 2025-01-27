# frozen_string_literal: true

require_relative '../lib/poros/book'

# :Load Book Class:
class LoadBooks

  def find_by(isbn:)
    books = CSV.read('data/books.csv', headers: true, col_sep: ';')

    books.each do |book|
      return create_book_object(book) if book['isbn'] == isbn
    end
  end

  private

  def create_book_object(book)
    Book.new(book[0], book['isbn'], book['description'])
  end
end
