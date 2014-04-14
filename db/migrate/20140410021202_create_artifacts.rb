class CreateArtifacts < ActiveRecord::Migration
  def change
    create_table :artifacts do |t|
      t.decimal :latitude, precision: 9, scale: 6
      t.decimal :longitude, precision: 9, scale: 6

      t.timestamps
    end
  end
end
