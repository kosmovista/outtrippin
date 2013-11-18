class Picture < ActiveRecord::Base
  mount_uploader :source, PictureUploader
end