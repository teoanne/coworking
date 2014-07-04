class AdditionalPhotosUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process :resize_to_fill => [250, 300]

  def store_dir
    'public/uploads'
  end

end