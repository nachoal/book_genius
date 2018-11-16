class BooksController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @books = Book.search(params[:search])

    # for the background
    book_images = Book.random_images(45)
    emoji_images = Emoji.random_images(15)
    @tile_images = (book_images + emoji_images).shuffle
  end

  def google_search
    google_books = GoogleBooksService.new.lists(params[:search])
    @books = []
    google_books.each do |book|
      @books << Book.new_with_google_json(book)
    end
    @books
  end

  def search
    respond_to do |format|
      format.html { redirect_to books_path(search: params[:search]) }
      format.js
    end
  end

  def show
    @book = Book.find(params[:id])

    book_images = Book.random_images(45)
    emoji_images = Emoji.random_images(15)
    @tile_images = (book_images + emoji_images).shuffle
  end
end
