class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true, optional: true
  mount_uploader :image, ImageUploader

  validates :image, file_size { less_than 3.megabytes }
end
