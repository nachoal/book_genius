class Book < ApplicationRecord
  mount_uploader :cover, PhotoUploader
end
