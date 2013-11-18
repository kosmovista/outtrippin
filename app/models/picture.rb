class Picture < ActiveRecord::Base
  mount_uploader :source, PictureUploader

  belongs_to :user
  has_and_belongs_to_many :pitches
end