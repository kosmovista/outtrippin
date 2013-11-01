class CreateItineraries < ActiveRecord::Migration
  def change
    create_table :itineraries do |t|
      t.string      :departure
      t.integer     :user_id
      t.string      :destination
      t.string      :duration
      t.integer     :description
      t.boolean     :paid
      t.text        :extra_info

      t.timestamps
    end
  end
end