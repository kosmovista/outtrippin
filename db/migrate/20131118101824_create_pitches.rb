class CreatePitches < ActiveRecord::Migration
  def change
    create_table :pitches do |t|
      t.string :title
      t.text :summary
      t.text :why_me
      t.integer :user_id
      t.integer :itinerary_id
      t.boolean :published
      t.boolean :winner

      t.timestamps
    end
  end
end
