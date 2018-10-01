# frozen_string_literal: true

class Image < ApplicationRecord
  mount_uploader :image, ImageUploader
  NOIMAGE_IMG = 'noimage.png'

  belongs_to :imageable, polymorphic: true, optional: true
end
