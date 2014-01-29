class FeaturedPlan < ActiveRecord::Base
  belongs_to :plan

  def self.toggle(plan)
    if self.featuring?(plan)
      self.where(plan_id: plan.id).first.delete
    else
      self.create(plan_id: plan.id)
    end
  end

  def self.featuring?(plan)
    !self.where(plan_id: plan.id).empty?
  end
end