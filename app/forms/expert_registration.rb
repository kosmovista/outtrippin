class ExpertRegistration
  include ActiveModel::Model

  def persisted?
    false
  end

  ATTRIBUTES = [:name, :email, :avatar, :password, :password_confirmation, :countries, :cities, :style, :bio, :website, :instagram, :hometown, :current_location, :facebook, :twitter, :story, :travel_hack ]

  attr_accessor *ATTRIBUTES

  def initialize(attributes = {})
    ATTRIBUTES.each do |attribute|
      send("#{attribute}=", attributes[attribute])
    end

    send("countries=", parsed_countries)
    send("cities=", parsed_cities)
    send("style=", parsed_styles)
  end

  # VALIDATIONS
  validate do
    errors[:name] = "Can't be blank" if name.blank?
    errors[:website] = "Can't be blank" if website.blank?
    errors[:cities] = "Enter at least one city" if cities.empty?
    errors[:countries] = "Enter at least one country" if countries.empty?
    errors[:style] = "Select at least one style" if style.empty?

  end


  # USER
  validate do
    unless user.valid?
      user.errors.each do |key, values|
        errors[key] = values
      end
    end
  end

  ##
  def user
    @user ||= User.new(email: email, avatar: avatar, password: password, password_confirmation: password_confirmation,
    personal_info: {
      name: name
    },
    expert_info: {
      website:      website,
      countries:    countries,
      cities:       cities,
      style:        style,
      bio:          bio,
      travel_hack:  travel_hack,
      facebook:     facebook,
      twitter:      twitter,
      instagram:    instagram,
      hometown:     hometown,
      current_location: current_location,
      story:        story
    })
    return @user
  end

  ##
  def save
    return false unless valid?
    if create_objects
      AdminMailer.new_expert_email(user).deliver # TODO ADD DELAYED JOB
      true
    else
      false
    end
  end

  private

  def parsed_countries
    return nil if countries.nil?
    acountries = countries.split('+')
    acountries.each { |c| c = c.chomp!(',').sub!(/^,/, '') }
    acountries
  end

  def parsed_cities
    return nil if cities.nil?
    acities = cities.split('+')
    acities.each { |c| c = c.chomp!(',').sub!(/^,/, '')}
    acities
  end

  def parsed_styles
    return nil if style.nil?
    _style = []
    style.each { |k, v| _style << k if v != "0" }
    _style
  end


  def create_objects
    ActiveRecord::Base.transaction do
      user.roles = ["expert"]
      user.save_without_session_maintenance
    end
  rescue
    false
  end
end