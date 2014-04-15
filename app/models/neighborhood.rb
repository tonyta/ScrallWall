class Neighborhood < ActiveRecord::Base
  scope :surrounding, -> (latitude, longitude) {
    where(%{
      ST_Contains(
        geom, ST_GeomFromText('SRID=4326;POINT(%f %f)')
      )
    } % [longitude, latitude])
  }

  scope :within, -> (latitude, longitude, neighborhood) {
  where(%{
    ST_Within(
      ST_GeomFromText(
        'SRID=4326;POINT(' || artifacts.longitude || ' ' || artifacts.latitude || ')'
        ),
      (select geom from neighborhoods where pri_neigh = '%s')
    } % [neighborhood])
  }
end
