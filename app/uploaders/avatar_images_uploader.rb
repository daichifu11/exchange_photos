class AvatarImagesUploader < CarrierWave::Uploader::Base
  if Rails.env.development?
    storage :fog
  elsif Rails.env.test?
    storage :file
  else
    storage :fog
  end


  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(png jpg jpeg)
  end

  def filename
    original_filename if original_filename
  end

  # minimagickを使うため
  include CarrierWave::MiniMagick 

  #サムネイルの為に画像をリサイズ
  version :thumb do 
    process resize_to_fit: [100, 100] 
  end 
  version :thumb50 do 
    process resize_to_fit: [50, 50] 
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*args) 
    "default_avatar.png"
  end
end
