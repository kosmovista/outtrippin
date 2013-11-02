class Itinerary < ActiveRecord::Base
  belongs_to :user, inverse_of: :itineraries

  default_scope { order('created_at DESC') }

  serialize :extra_info, Hash
  validates_presence_of :destination
end
