class AddIsInSaleToCase < ActiveRecord::Migration[5.1]
  def change
    add_column :cases, :is_in_sale, :boolean, default: false
    add_column :cases, :sale_price, :integer
  end
end
