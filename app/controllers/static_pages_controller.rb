class StaticPagesController < ApplicationController
   skip_before_action :authenticate_user!, only: [:index, :show, :about, :collection, :all_collections, :search_collections]
  def index
  end

  def show
  end

  def about
  end

  def collection
    @collection = OpenStruct.new(books: Book.first(10))
  end

  def all_collections
  end

  def search_collections
  end

end
