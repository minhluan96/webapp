class AddActiveStatusToCaseCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :case_categories, :active, :boolean
  end
end
