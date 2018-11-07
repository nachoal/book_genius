class Book < ApplicationRecord
  has_many :tweets
  has_many :aylien_book_results
  mount_uploader :book_image, PhotoUploader
end
