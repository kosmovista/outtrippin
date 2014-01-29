class CreateFeaturedPlans < ActiveRecord::Migration
  def change
    create_table :featured_plans do |t|
      t.integer :plan_id
    end
  end
end