class StaticPagesController < ApplicationController
   skip_before_action :authenticate_user!, only: [:index, :show, :about, :collection, :all_collections, :search_collections]

  def home
  end

  def show
  end

  def about
    book_images = Book.random_images(45)
    emoji_images = Emoji.random_images(15)
    @tile_images = (book_images + emoji_images).shuffle
  end

  def collection
    @collection = OpenStruct.new(books: Book.first(10))
  end

  def all_collections
  end

  def search_collections
  end

end
