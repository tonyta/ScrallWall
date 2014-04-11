class ChangeAssociationsBetweenLocationsAndArtifacts < ActiveRecord::Migration
  def change
    add_column :artifacts, :latitude, :float
    add_column :artifacts, :longitude, :float
    remove_column :artifacts, :geotag
    remove_column :artifacts, :location_id
    drop_table :locations
  end
end
