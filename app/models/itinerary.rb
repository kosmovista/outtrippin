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

  after_create :update_places

  def price
    10 * self.duration.to_i
  end

  def self.published
    Itinerary.where(published: true)
  end

  def price_in_cents(plan)
    plan * self.duration.to_i * 100
  end

  def user_source
    if self.extra_info.has_key?(:source)
      if self.extra_info[:source] == "hotel"
        "Hotel"
      elsif self.extra_info[:source] == "OutTrippin"
        "OutTrippin"
      else
        "Zuji"
      end
    else
      "OutTrippin"
    end
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

  def has_personalized_pitches?
    !self.pitches.where(auto: false).first.nil?
  end

  def has_auto_pitches?
    !self.pitches.where(auto: true).first.nil?
  end

  def get_pitches_from_place(place)
    place.pitches.each do |p|
      copy_pitch = p.dup
      copy_pitch.auto = true
      copy_pitch.winner = false
      copy_pitch.place_id = nil
      copy_pitch.pictures = p.pictures
      copy_pitch.save
      self.pitches << copy_pitch
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

  def update_places
    sanitized_destination = self.destination.downcase.strip
    place = Place.find_by_name(sanitized_destination)
    if place.nil?
      place = Place.create(name: sanitized_destination)
    else
    end
  end
end