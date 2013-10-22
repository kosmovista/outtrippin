class User < ActiveRecord::Base
  ROLES = %w[admin expert]
  # default_scope { order('created_at DESC') }
  serialize :personal_info, Hash
  serialize :expert_info, Hash

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
end