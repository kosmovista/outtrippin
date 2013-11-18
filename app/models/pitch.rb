class Pitch < ActiveRecord::Base
  belongs_to :user, inverse_of: :pitches
  belongs_to :itinerary, inverse_of: :pitches
end
