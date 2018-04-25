class CreateCases < ActiveRecord::Migration[5.1]
  def change
    create_table :cases do |t|
      t.string :name
      t.string :image
      t.string :description
      t.integer :price

      t.timestamps
    end
  end
end
