class Pitch < ActiveRecord::Base
  belongs_to :user, inverse_of: :pitches
  belongs_to :itinerary, inverse_of: :pitches

  has_and_belongs_to_many :pictures

  def won_by?(user)
    return false if !self.winner
    return true if self.user == user
    return false
  end
end