class AddAutomaticToPitches < ActiveRecord::Migration
  def change
    add_column :pitches, :auto, :boolean, default: false
  end
end