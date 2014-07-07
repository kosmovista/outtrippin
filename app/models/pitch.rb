class Pitch < ActiveRecord::Base
  belongs_to :user, inverse_of: :pitches
  belongs_to :itinerary, inverse_of: :pitches
  belongs_to :place, inverse_of: :pitches

  has_and_belongs_to_many :pictures

  def won_by?(user)
    return false if !self.winner
    return true if self.user == user
    return false
  end

  def written_by?(user)
    return true if self.user == user
    return false
  end
  
  def self.find_by_user(user)
    pitches = Pitch.where(user_id: user.id)
    pitches
  end

  def self.find_winner_expert_by_itinerary(user)
    pitches = Pitch.where(user_id: user.id, winner: true).map { |p| p.itinerary }
    pitches
  end
end