class ExpertRegistration
  include ActiveModel::Model

  def persisted?
    false
  end

  ATTRIBUTES = [:email, :personal_info, :expert_info, :avatar, :password]

  attr_accessor *ATTRIBUTES

  def initialize(attributes = {})
    ATTRIBUTES.each do |attribute|
      send("#{attribute}=", attributes[attribute])
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
    @user ||= User.new(email: email)
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

  def create_objects
    ActiveRecord::Base.transaction do
      user.save!
    end
  rescue
    false
  end
end