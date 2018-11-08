class BooksController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @books = Book.all
  end

  def show
  end
end
