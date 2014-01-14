class AddDraftToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :draft, :boolean, default: true
    change_column :plans, :published, :boolean, default: false
  end
end
