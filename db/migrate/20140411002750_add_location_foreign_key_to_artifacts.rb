class AddLocationForeignKeyToArtifacts < ActiveRecord::Migration
  def change
    add_column :artifacts, :location_id, :integer
  end
end
