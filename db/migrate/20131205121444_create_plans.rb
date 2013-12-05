class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :title
      t.text :days
      t.text :tips_tricks
      t.boolean :published
      t.integer :user_id
      t.integer :itinerary_id

      t.timestamps
    end
  end
end