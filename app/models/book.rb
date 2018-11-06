class Book < ApplicationRecord
  mount_uploader :book_image, PhotoUploader
end
