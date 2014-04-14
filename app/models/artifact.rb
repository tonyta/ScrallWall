class Artifact < ActiveRecord::Base
  belongs_to :neighborhood

  has_many :pictures
  has_many :reflections

  has_many :artifact_tags
  has_many :tags, through: :artifact_tags

  has_many :favs
  has_many :favoritors, through: :favs, source: :user_id

  scope :near, -> (latitude, longitude, distance_in_meters = 250) {
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

  def neighbors(radius=nil)
    if radius
      Artifact.near(self.latitude, self.longitude, radius)
    else
      Artifact.near(self.latitude, self.longitude)
    end
  end

  def canonical_picture
    self.pictures.first
  end
end
