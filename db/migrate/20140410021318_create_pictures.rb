class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :artifact_id
      t.string :image

      t.timestamps
    end
  end
end
