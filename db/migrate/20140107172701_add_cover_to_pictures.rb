class AddCoverToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :cover, :boolean, default: false
  end
end
