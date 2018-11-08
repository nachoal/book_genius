class Book < ApplicationRecord
  has_many :tweets, dependent: :delete_all
  has_many :amazon_reviews, dependent: :delete_all
  has_many :aylien_book_results, dependent: :delete_all
  mount_uploader :book_image, PhotoUploader
end
