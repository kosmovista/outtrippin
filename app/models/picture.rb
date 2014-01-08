class Picture < ActiveRecord::Base
  mount_uploader :source, PictureUploader

  belongs_to :user
  has_and_belongs_to_many :pitches
  has_and_belongs_to_many :plans

  scope :cover, -> { where(cover: true) }
end