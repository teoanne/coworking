class MainPhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process :resize_to_fill => [665, 375]

  def store_dir
    'public/uploads'
  end
  
end