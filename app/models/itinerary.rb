class Itinerary < ActiveRecord::Base
  belongs_to :user, inverse_of: :itineraries

  serialize :extra_info, Hash
  validates_presence_of :destination
end
