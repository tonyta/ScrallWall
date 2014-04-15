class Artifact < ActiveRecord::Base
  belongs_to :neighborhood

  has_many :pictures
  has_many :reflections

  has_many :artifact_tags
  has_many :tags, through: :artifact_tags

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

  def neighborhood
    Neighborhood.surrounding(self.latitude, self.longitude).first
  end

  def canonical_picture
    self.pictures.first
  end

  def picture_urls
    self.pictures.map {|p| p.image.preview.url }
  end

  def to_map_marker
    image = self.canonical_picture.image
    { lat: self.latitude,
      lng: self.longitude,
      map_thumb: image.map_thumb.url,
      info_thumb: image.thumb.url,
      show_url: "/artifacts/#{self.id}"
    }
  end

  def self.all_with_picture
    # this could be optimized
    self.all.select { |a| a.pictures.count > 0 }
  end
end
