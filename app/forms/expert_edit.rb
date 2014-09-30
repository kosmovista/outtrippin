class ExpertEdit
  include ActiveModel::Model

  def persisted?
    false
  end

  ATTRIBUTES = [:name, :email, :avatar, :password, :password_confirmation, :countries, :cities, :style, :bio, :website, :paypal, :rss, :instagram, :google, :hometown, :current_location, :facebook, :twitter, :story, :travel_hack, :pinterest ]
  EXPERT_ATTRIBUTES = %w(countries cities style bio website paypal rss instagram google hometown current_location facebook twitter story travel_hack)

  attr_accessor *ATTRIBUTES

  def initialize(options = {})
    attributes = options[:attributes]
    attributes[:facebook] = attributes[:facebook].gsub!(/.*?(?=facebook)/im, "") unless attributes.nil?

    @user = options[:user]
    raise ArgumentError, "You need to be an expert" if !@user.is?("expert")

    unless attributes.nil?
      ATTRIBUTES.each do |attribute|
        send("#{attribute}=", attributes[attribute])
      end
      send("countries=", parsed_countries)
      send("cities=", parsed_cities)
      send("style=", parsed_styles)
    else
      send("name=", @user.name)
      send("email=", @user.email)
      # TODO avatar
      # TODO password
      EXPERT_ATTRIBUTES.each do |attr|
        send("#{attr}=", @user.expert_info[attr.to_sym])
      end
    end
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
    unless @user.valid?
      @user.errors.each do |key, values|
        errors[key] = values
      end
    end
  end

  ##
  def save
    return false unless valid?
    if update_objects
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

  def update_objects
    ActiveRecord::Base.transaction do
      @user.personal_info[:name] = name unless name.nil?
      @user.email = email unless email.nil?
      EXPERT_ATTRIBUTES.each do |attr|
        @user.expert_info[attr.to_sym] = self.send(attr)
      end
      @user.save
    end
  rescue
    false
  end
end