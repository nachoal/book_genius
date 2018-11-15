class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    book_images = Book.random_images(45)
    emoji_images = Emoji.random_images(15)
    @tile_images = (book_images + emoji_images).shuffle
  end

end
