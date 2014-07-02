class ItineraryDetails
  include ActiveModel::Model

  def persisted?
    false
  end

  ATTRIBUTES = [:name, :travelers, :departure, :duration, :style, :booked]

  attr_accessor *ATTRIBUTES

  def initialize(options = {})
    attributes = options[:attributes]
    @itinerary = options[:itinerary]
    raise ArgumentError, "You need to supply an itinerary" if @itinerary.nil?

    unless attributes.nil?
      ATTRIBUTES.each do |attribute|
        send("#{attribute}=", attributes[attribute])
      end

      send("style=", parsed_styles)
      send("booked=", parsed_booked)
    end
  end

  validate do
    errors[:style] = "Select at least one style" if style.empty?
  end

  def save
    return false unless valid?
    if create_objects
      true
    else
      false
    end
  end

  private

  def create_objects
    ActiveRecord::Base.transaction do
      extra_info = { style: style, name: name, travelers: travelers, booked: booked, source: @itinerary.extra_info[:source] }
      @itinerary.update_attributes(departure: departure, duration: duration, extra_info: extra_info)
      @itinerary.save!
    end
  rescue
    false
  end

  # TODO repeated code
  def parsed_styles
    return nil if style.nil?
    _style = []
    style.each { |k, v| _style << k if v != "0" }
    _style
  end

  def parsed_booked
    return nil if booked.nil?
    _booked = []
    booked.each { |k, v| _booked << k if v != "0" }
    _booked
  end
end