class Neighborhood < ActiveRecord::Base
  scope :surrounding, -> (latitude, longitude) {
    where(%{
      ST_Contains(
        geom, ST_GeomFromText('SRID=4326;POINT(%f %f)')
      )
    } % [longitude, latitude])
  }
end
