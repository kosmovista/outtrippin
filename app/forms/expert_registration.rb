class ExpertRegistration
  include ActiveModel::Model

  def persisted?
    false
  end

  ATTRIBUTES = [:email, :personal_info, :expert_info, :avatar, :password, :password_confirmation]

  attr_accessor *ATTRIBUTES

  def initialize(attributes = {})

    ATTRIBUTES.each do |attribute|
      send("#{attribute}=", attributes[attribute])
    end

    unless expert_info.nil?
      expert_info[:countries] = parsed_countries
      expert_info[:cities] = parsed_cities
      expert_info[:style] = parsed_style
    end

  end

  # VALIDATIONS
  validate do
    unless user.valid?
      user.errors.each do |key, values|
        errors[key] = values
      end
    end
  end

  ##
  def user
    @user ||= User.new(email: email, personal_info: personal_info, expert_info: expert_info, password: password, password_confirmation: password_confirmation)
    return @user
  end

  ##
  def save
    return false unless valid?
    if create_objects
      # SEND EMAILS AND STUFF
      true
    else
      false
    end
  end

  private

  def parsed_countries
    acountries = expert_info[:countries].split('+')
    acountries.each { |c| c = c.chomp!(',').sub!(/^,/, '') }
  end

  def parsed_cities
    acities = expert_info[:cities].split('+')
    acities.each { |c| c = c.chomp!(',').sub!(/^,/, '')}
  end

  def parsed_style
    style = []
    expert_info[:style].each { |k, v| style << k if v != "0" }
    return style
  end


  def create_objects
    ActiveRecord::Base.transaction do
      user.save!
    end
  rescue
    false
  end
end