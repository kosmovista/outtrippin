class AddUsersPasswordResetFields < ActiveRecord::Migration
  def change
    add_column :users, :perishable_token, :string, default: "", null: ""
    add_index :users, :perishable_token
  end
end
