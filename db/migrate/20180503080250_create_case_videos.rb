class CreateCaseVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :case_videos do |t|
      t.references :case
      t.string :video_url

      t.timestamps
    end
  end
end
