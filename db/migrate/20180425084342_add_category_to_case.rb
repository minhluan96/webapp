class AddCategoryToCase < ActiveRecord::Migration[5.1]
  def change
    add_reference :cases, :category
  end
end
