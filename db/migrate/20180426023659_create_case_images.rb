class CreateCaseImages < ActiveRecord::Migration[5.1]
  def change
    create_table :case_images do |t|
      t.references :case
      t.string :image_url

      t.timestamps
    end
  end
end
