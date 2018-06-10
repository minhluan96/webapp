class CreateOrderDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :order_details do |t|
      t.references :order_details
      t.references :cases
      t.integer :price
      t.integer :capical
      t.integer :quantity

      t.timestamps
    end
  end
end
