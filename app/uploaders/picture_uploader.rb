class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}"
  end

  version :show do
    process resize_to_fit: [800, 800]
  end

  version :preview do
    process resize_to_fit: [600, 600]
  end

  version :thumb do
    process resize_to_fit: [120, nil]
  end

  version :map_show do
    process resize_to_fit: [200, nil]
  end

  version :map_thumb do
    process resize_to_fill: [24, 24]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
     "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
