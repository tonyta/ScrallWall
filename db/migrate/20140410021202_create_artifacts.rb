class CreateArtifacts < ActiveRecord::Migration
  def change
    create_table :artifacts do |t|
      t.integer :neighborhood_id
      t.string :geotag

      t.timestamps
    end
  end
end
