class AddBookingsToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :bookings, :text
  end
end