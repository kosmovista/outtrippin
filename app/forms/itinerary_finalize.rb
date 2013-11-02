class ItineraryFinalize
  include ActiveModel::Model

  def persisted?
    false
  end

  ATTRIBUTES = [:name, :budget, :travelers, :email, :details]

  attr_accessor *ATTRIBUTES

  def initialize(options = {})
    attributes = options[:attributes]
    @itinerary = options[:itinerary]
    raise ArgumentError, "You need to supply an itinerary" if @itinerary.nil?

    unless attributes.nil?
      ATTRIBUTES.each do |attribute|
        send("#{attribute}=", attributes[attribute])
      end

    end
  end

  validate do
    @user = User.find_by_email(email)
    unless user.valid?
      user.errors.each do |key, values|
        errors[key] = values
      end
    end
  end

  def user
    password = "taxasman"
    @user ||= User.new(email: email, password: password, password_confirmation: password)
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
      extra_info = { name: name, budget: budget, travelers: travelers, details: details, style: @itinerary.extra_info[:style] }
      user.save!
      @itinerary.update_attributes(extra_info: extra_info, user: user)
      @itinerary.save!
    end
  rescue
    false
  end
end