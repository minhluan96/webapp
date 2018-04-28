class AddIndexToCaseCategory < ActiveRecord::Migration[5.1]
  def change
    add_index :case_categories, [:case_id, :category_id], unique: true, name: 'index_case_category'
  end
end
