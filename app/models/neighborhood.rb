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
end
