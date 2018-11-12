class Collection < ApplicationRecord
  has_many :book_collections, dependent: :destroy
  has_many :books, through: :book_collections
end
