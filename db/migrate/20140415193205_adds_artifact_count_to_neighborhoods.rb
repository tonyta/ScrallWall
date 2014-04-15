class AddsArtifactCountToNeighborhoods < ActiveRecord::Migration
  def change
    add_column :neighborhoods, :artifact_count, :integer, default: 0, null:false

    Neighborhood.all.each do |n|
      n.artifact_count = n.artifacts.length
      n.save!
    end
  end
end
