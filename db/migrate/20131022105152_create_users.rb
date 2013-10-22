class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.text :personal_info
      t.text :expert_info
      t.string :avatar
      t.integer :roles_mask

      t.timestamps
    end
  end
end
