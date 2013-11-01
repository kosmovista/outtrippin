class User < ActiveRecord::Base
  ROLES = %w[admin expert]

  default_scope { order('created_at DESC') }

  serialize :personal_info, Hash
  serialize :expert_info, Hash

  # Authlogic configuration
  acts_as_authentic

  # Carrierwave
  mount_uploader :avatar, AvatarUploader

  validates_presence_of :email

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
  # (end) ROLE MANAGER LOGIC

  def expert?
    self.is?("expert")
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

  def twitter
    self.expert_info[:twitter]
  end

  def hometown
    self.expert_info[:hometown]
  end

  def location
    self.expert_info[:location]
  end


end