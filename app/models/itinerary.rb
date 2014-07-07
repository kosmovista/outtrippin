class Itinerary < ActiveRecord::Base
  include Chargeable

  acts_as_votable

  belongs_to :user, inverse_of: :itineraries
  has_many :pitches, inverse_of: :itinerary
  has_many :plans, inverse_of: :itinerary

  attr_accessor :source

  default_scope { order('created_at DESC') }

  serialize :extra_info, Hash
  validates_presence_of :destination

  def price
    10 * self.duration.to_i
  end

  def self.published
    Itinerary.where(published: true)
  end

  def price_in_cents(plan)
    plan * self.duration.to_i * 100
  end

  def process_payment(token, plan)
    if self.valid?
      self.charge(token, plan)
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

  def get_pitches_from_place(place)
    puts "\n\nWILL COPY PITCHES"
    self.pitches = place.pitches.dup

    self.save
    self.pitches.each do |p|
      p.winner = false
      p.save
    end
  end

  # PLANS
  def get_plan_from(user)
    self.plans.where(user: user).first
  end

  def get_plan
    self.plans.first
  end

  def has_plan?
    self.plans.size > 0
  end

  # getters
  def name
    self.extra_info[:name]
  end
  def travelers
    self.extra_info[:travelers]
  end

end