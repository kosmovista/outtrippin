class CreatePicturesPitches < ActiveRecord::Migration
  def change
    create_table :pictures_pitches do |t|
      t.integer :picture_id
      t.integer :pitch_id
    end
  end
end
