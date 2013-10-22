class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.text :personal_info
      t.text :expert_info
      t.string :avatar
      t.integer :roles_mask

      # authlogic basics
      t.string :crypted_password, null: false
      t.string :password_salt, null: false
      t.string :persistence_token, null: false

      t.timestamps
    end
  end
end