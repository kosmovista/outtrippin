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
    if @user
      return @user
    else
      @password = generate_password
      @user ||= User.new(email: email, password: @password, password_confirmation: @password)
    end
  end

  def save
    return false unless valid?
    send_user_email = true if @user.new_record?
    if create_objects
      UserMailer.delay.welcome_user_email(user, @password) if send_user_email
      AdminMailer.delay.new_itinerary_email(@itinerary)
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

  private
  def generate_password
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    (0...8).map{ o[rand(o.length)] }.join
  end
end