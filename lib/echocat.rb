# frozen_string_literal: true

require 'csv'
require_relative '../bin/load_authors'
require_relative '../bin/load_books'

# Echocat Module
module Echocat
  def self.run
    puts '*********************************************'
    puts 'MAIN TASK-1&2: Printing authors, with their books & magazines'
    puts '*********************************************'

    authors = LoadAuthors.new.authors
    authors.each do |author|
      puts "Author's Info:"
      puts "Email: #{author.email}"
      puts "Firstname: #{author.firstname}"
      puts "Lastname: #{author.lastname}"

      puts '-------------------------------------'

      puts "Books published by #{author.full_name}:"
      author.books.each do |book|
        puts "Title: #{book.title}"
        puts "Isbn: #{book.isbn}"
        puts "Description: #{book.description}"
        puts '_________________________________'
      end

      puts '-------------------------------------'

      puts "Magazines published by #{author.full_name}:"
      author.magazines.each do |magazine|
        puts "Title: #{magazine.title}"
        puts "Isbn: #{magazine.isbn}"
        puts "Published At: #{magazine.published_at}"
        puts '_________________________________'
      end
    end

    puts '=============================================='

    puts '*********************************************'
    puts 'MAIN-TASK-3: Finding a book or magazine by its isbn'
    puts '*********************************************'

    book = LoadBooks.new.find_by(isbn: '3214-5698-7412')
    puts 'Book found by ISBN'
    puts "Title: #{book.title}"
    puts "Description: #{book.description}"
    puts '*********************************************'

    puts '=============================================='

    puts '*********************************************'
    puts 'MAIN TASK-4: Finding Books & Magazine by author email'
    puts '*********************************************'

    author1 = LoadAuthors.new.find_by(email: 'null-walter@echocat.org')
    puts "Author's Info:"
    puts "Email: #{author1.email}"
    puts "Firstname: #{author1.full_name}"

    puts '-------------------------------------'

    puts "Books published by #{author1.full_name}:"
    author1.books.each do |book|
      puts "Title: #{book.title}"
      puts "Isbn: #{book.isbn}"
      puts "Description: #{book.description}"
      puts '_________________________________'
    end

    puts '-------------------------------------'

    puts "Magazines published by #{author1.full_name}:"
    author1.magazines.each do |magazine|
      puts "Title: #{magazine.title}"
      puts "Isbn: #{magazine.isbn}"
      puts "Published At: #{magazine.published_at}"
      puts '_________________________________'
    end

    puts '=============================================='

    puts '*********************************************'
    puts 'MAIN TASK-5: Printing Books & Magazines by sorting title'
    puts '*********************************************'

    books = authors.map(&:books).flatten
    magazines = authors.map(&:magazines).flatten
    books_and_magazines = books + magazines
    sorted_books_and_magazines = books_and_magazines.sort_by.with_index { |obj| obj.title }
    sorted_books_and_magazines.each do |object|
      puts "Title: #{object.title}"
      puts "Isbn: #{object.isbn}"
      if object.class == Book
        puts "Description: #{object.description}"
      else
        puts "Published At: #{object.published_at}"
      end
      puts '_________________________________'
    end

    puts '*********************************************'
    puts 'OPTIONAL TASK-3: Generating CSV file for Books & Magazines'
    puts '*********************************************'

    CSV.open('books.csv', 'w') do |csv|
      csv << %w[title isbn description]
      books.each do |book|
        new_book = []
        new_book.push(book.title, book.isbn, book.description)
        csv << new_book
      end
    end

    CSV.open('magazines.csv', 'w') do |csv|
      csv << %w[title isbn publishedAt]
      magazines.each do |magazine|
        new_magazine = []
        new_magazine.push(magazine.title, magazine.isbn, magazine.published_at)
        csv << new_magazine
      end
    end
  end
end
