class EditCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :is_tempered_glass, :boolean, default: false
  end
end
