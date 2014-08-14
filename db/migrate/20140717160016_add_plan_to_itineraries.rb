class AddPlanToItineraries < ActiveRecord::Migration
  def change
    add_column :itineraries, :plan, :integer
  end
end
