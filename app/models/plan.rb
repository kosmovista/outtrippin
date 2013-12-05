class Plan < ActiveRecord::Base
  belongs_to :user, inverse_of: :plans
  belongs_to :itinerary, inverse_of: :plans

  has_and_belongs_to_many :pictures

  serialize :tips_tricks, Array
  serialize :days, Array
end
