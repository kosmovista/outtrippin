class Plan < ActiveRecord::Base
  belongs_to :user, inverse_of: :plans
  belongs_to :itinerary, inverse_of: :plans

  has_and_belongs_to_many :pictures

  default_scope { order('created_at DESC') }

  serialize :tips_tricks, Array
  serialize :days, Array

  def cover
    begin
      self.pictures.cover.first.source.url.to_s
    rescue
      return nil
    end
  end
end
