class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :user_id
      t.integer :artifact_id
      t.string :url
      t.string :thumb_url

      t.timestamps
    end
  end
end
