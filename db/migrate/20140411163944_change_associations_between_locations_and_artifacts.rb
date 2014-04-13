class ChangeAssociationsBetweenLocationsAndArtifacts < ActiveRecord::Migration
  def change
    add_column :artifacts, :latitude, :decimal, precision: 9, scale: 6
    add_column :artifacts, :longitude, :decimal, precision: 9, scale: 6
    remove_column :artifacts, :geotag
    remove_column :artifacts, :location_id
    drop_table :locations
  end
end
