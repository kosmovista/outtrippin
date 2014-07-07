class AddPlaceIdToPitches < ActiveRecord::Migration
  def change
    add_column :pitches, :place_id, :integer
  end
end
