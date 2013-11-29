# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def fog_directory
    "avatars"
  end

  def asset_host
    if Rails.env.production?
      "http://fe5f910fe9492af904f7-d923a624db3b3940ce48298d73fff237.r75.cf1.rackcdn.com"
    else
      "http://localhost:3000"
    end
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "http://fe5f910fe9492af904f7-d923a624db3b3940ce48298d73fff237.r75.cf1.rackcdn.com/avatar.png"
  end

  version :thumb do
    process :resize_to_fill => [180, 180]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end