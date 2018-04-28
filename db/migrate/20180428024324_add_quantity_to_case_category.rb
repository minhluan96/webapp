class AddQuantityToCaseCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :case_categories, :quantity, :integer, default: 1
  end
end
