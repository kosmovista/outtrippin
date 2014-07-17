class Pitch < ActiveRecord::Base
  belongs_to :user, inverse_of: :pitches
  belongs_to :itinerary, inverse_of: :pitches
  belongs_to :place, inverse_of: :pitches

  has_and_belongs_to_many :pictures

  after_create :add_to_places

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

  def self.personalized
    pitches = Pitch.where(auto: false)
  end

  def self.auto
    pitches = Pitch.where(auto: true)
  end

  def add_to_places
    # if auto pitch -> SKIP
    unless self.auto?
      sanitized_destination = self.itinerary.destination.downcase.strip
      place = Place.find_by_name(sanitized_destination)
      if place.nil?
        place = Place.create(name: sanitized_destination)
      else
      end
      self.place_id = place.id
      self.save
    end
  end
end