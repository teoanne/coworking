class AdditionalPhotosUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process :resize_to_fill => [160, 200]

  def store_dir
    'public/uploads'
  end

end