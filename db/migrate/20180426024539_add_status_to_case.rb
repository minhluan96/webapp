class AddStatusToCase < ActiveRecord::Migration[5.1]
  def change
    add_column :cases, :is_available, :boolean, default: true
    add_column :cases, :is_top_sales, :boolean, default: false
  end
end
