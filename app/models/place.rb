class Place < ActiveRecord::Base
  has_many :pitches, inverse_of: :place
end
