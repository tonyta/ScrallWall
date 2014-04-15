class Neighborhood < ActiveRecord::Base
  scope :containing, -> (latitude, longitude) {
    where(%{
      ST_Contains(
        geom, ST_GeomFromText('SRID=4326;POINT(%f %f)')
      )
    } % [longitude, latitude])
  }

  def artifacts
    Artifact.contained_within(self.geom)
  end

  def name
    self.pri_neigh
  end

  def update_cache
    self.artifact_count = self.artifacts.length
    self.save!
  end

  def self.all_with_artifacts
    self.where('artifact_count > 0')
  end
end
