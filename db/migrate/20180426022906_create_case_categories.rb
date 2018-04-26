class CreateCaseCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :case_categories do |t|
      t.references :case
      t.references :category

      t.timestamps
    end
    add_index :case_categories, [:case_id, :category_id], name: 'case_category_index'
  end
end
