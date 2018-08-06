class RenameOrderDetailsColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :order_details, :capical, :cogs
    remove_reference :order_details, :cases
    remove_reference :order_details, :order_details
    add_reference :order_details, :case_categories
    add_column :order_details, :revenue, :integer
  end
end
