class User < ActiveRecord::Base
  ROLES = %w[admin expert]

  acts_as_voter

  default_scope { order('created_at DESC') }

  serialize :personal_info, Hash
  serialize :expert_info, Hash

  # Authlogic configuration
  acts_as_authentic do |user|
    user.perishable_token_valid_for = 24.hours
  end


  # Kaminari (pagination)
  paginates_per 50

  # Carrierwave
  mount_uploader :avatar, AvatarUploader

  validates_presence_of :email
  validates_uniqueness_of :email, message: "This email is already registered. Want to <a href='/login'>login</a> or <a href='/password_resets/new'>recover</a> your password?"

  has_many :itineraries, dependent: :destroy, inverse_of: :user
  has_many :pictures
  has_many :pitches, inverse_of: :user
  has_many :plans, inverse_of: :user

  # ROLE MANAGER LOGIC
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def is?(role)
    roles.include?(role.to_s)
  end

  def self.experts
    User.where(roles_mask: 2)
  end

  def self.admins
    User.where(roles_mask: [1,3])
  end

  def self.customers
    User.where(roles_mask: nil)
  end

  def expert?
    self.is?("expert")
  end

  def admin?
    self.is?("admin")
  end
  # (end) ROLE MANAGER LOGIC

  def has_itineraries?
    self.itineraries.count > 0
  end

  def name
    self.personal_info[:name]
  end

  def website
    self.expert_info[:website]
  end

  def facebook
    self.expert_info[:facebook]
  end

  def instagram
    self.expert_info[:instagram]
  end

  def google
    self.expert_info[:google]
  end

  def paypal
    self.expert_info[:paypal]
  end

  def rss
    self.expert_info[:rss]
  end

  def pinterest
    self.expert_info[:pinterest]
  end

  def twitter
    self.expert_info[:twitter]
  end

  def cities
    self.expert_info[:cities]
  end

  def countries
    self.expert_info[:countries]
  end

  def hometown
    self.expert_info[:hometown]
  end

  def location
    self.expert_info[:current_location]
  end

  def geo_expertise
    if self.expert?
      begin
        (([self.hometown, self.location] + self.countries + self.cities).join(", "))
      rescue
        nil
      end
    else
      nil
    end
  end

  # TODO generalize
  def owns?(itinerary)
    self.itineraries.include?(itinerary)
  end
end