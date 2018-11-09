class Book < ApplicationRecord
  has_many :tweets, dependent: :delete_all
  has_many :amazon_reviews, dependent: :delete_all
  has_many :aylien_book_results, dependent: :delete_all
  has_many :book_collections, dependent: :destroy
  has_many :collections, through: :book_collections
  mount_uploader :book_image, PhotoUploader
end
