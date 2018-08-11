class AddActiveStatusToCase < ActiveRecord::Migration[5.1]
  def change
    add_column :cases, :active, :boolean, default: true
  end
end
