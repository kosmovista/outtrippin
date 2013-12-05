class Itinerary < ActiveRecord::Base
  include Chargeable

  belongs_to :user, inverse_of: :itineraries
  has_many :pitches, inverse_of: :itinerary
  has_many :plans, inverse_of: :itinerary

  default_scope { order('created_at DESC') }

  serialize :extra_info, Hash
  validates_presence_of :destination

  def price
    10 * self.duration.to_i
  end

  def price_in_cents
    10 * self.duration.to_i * 100
  end

  def process_payment(token)
    if self.valid?
      self.charge(token)
      self.paid = true
      self.save
      return true
    else
      return false
    end
  rescue Stripe::CardError => e
    logger.error "Stripe Error"
    errors.add :base, "There was a problem while processing the payment."
    false
  end

  # PITCHES
  def has_winner_pitch?
    !self.pitches.where(winner: true).first.nil?
  end

  def winner_pitch
    self.pitches.where(winner: true).first
  end

  # PLANS
  def get_plan_from(user)
    self.plans.where(user: user).first
  end
end