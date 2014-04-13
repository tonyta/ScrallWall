class Artifact < ActiveRecord::Base
  acts_as_mappable :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  belongs_to :neighborhood

  has_many :pictures
  has_many :reflections

  has_many :artifact_tags
  has_many :tags, through: :artifact_tags

  has_many :favs
  has_many :favoritors, through: :favs, source: :user_id

  scope :close_to, -> (latitude, longitude, distance_in_meters = 2000) {
    where(%{
      ST_DWithin(
        ST_GeographyFromText(
          'SRID=4326;POINT(' || artifacts.latitude || ' ' || artifacts.longitude || ')'
        ),
        ST_GeographyFromText('SRID=4326;POINT(%f %f)'),
        %d
      )
    } % [latitude, longitude, distance_in_meters])
    .order(%{
      'SRID=4326;POINT(' || artifacts.latitude || ' ' || artifacts.longitude || ')' <->
      'SRID=4326;POINT(%f %f)'
    } % [latitude, longitude])
  }

  scope :closest_to, -> (latitude, longitude, distance_in_meters = 2000) {
    where(%{
      ST_DWithin(
        ST_GeographyFromText(
          'SRID=4326;POINT(' || artifacts.latitude || ' ' || artifacts.longitude || ')'
        ),
        ST_GeographyFromText('SRID=4326;POINT(%f %f)'),
        %d
      )
    } % [latitude, longitude, distance_in_meters])
  }
end
