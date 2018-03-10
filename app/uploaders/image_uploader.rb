class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # best sellers and catalog view
  version :thumb do
    process resize_to_fit: [175, 220]
  end

  version :smallbook_image do
    process resize_to_fit: [177, 177]
  end

  version :book_image do
    process resize_to_fit: [570, 570]
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end
