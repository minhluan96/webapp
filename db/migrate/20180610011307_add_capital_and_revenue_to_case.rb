class AddCapitalAndRevenueToCase < ActiveRecord::Migration[5.1]
  def change
    add_column :cases, :capital, :integer
  end
end
