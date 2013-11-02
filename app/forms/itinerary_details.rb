class ItineraryDetails
  include ActiveModel::Model

  def persisted?
    false
  end

  ATTRIBUTES = [:departure, :duration, :style]

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
    end
  end

  validate do
    errors[:style] = "Select at least one style" if style.empty?
  end

  def save
    return false unless valid?
    if create_objects
      # UserMailer.welcome_expert_email(user).deliver
      # AdminMailer.new_expert_email(user).deliver # TODO ADD DELAYED JOB
      true
    else
      false
    end
  end

  private

  def create_objects
    ActiveRecord::Base.transaction do
      extra_info = { style: style }
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
end