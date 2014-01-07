class CreatePicturesPlans < ActiveRecord::Migration
  def change
    create_table :pictures_plans do |t|
      t.integer :picture_id
      t.integer :plan_id
    end
  end
end