class BooksController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @books = Book.search(params[:search])
  end

  def google_search

    results = HTTpppppp
    items = results['items']
    @books = items.map do |item|
      Book.new_with_google_json(item)
    end
  end

  def search
    respond_to do |format|
      format.html { redirect_to books_path(search: params[:search]) }
      format.js
    end
  end
end
