class AddPublishedToItineraries < ActiveRecord::Migration
  def change
    add_column :itineraries, :published, :boolean, default: false
  end
end