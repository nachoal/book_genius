class BookCollection < ApplicationRecord
  belongs_to :collection
  belongs_to :book
end
