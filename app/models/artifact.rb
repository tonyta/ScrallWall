require 'net/http'
require 'json'

class Artifact < ActiveRecord::Base
  belongs_to :neighborhood

  has_many :pictures
  has_many :reflections

  has_many :artifact_tags
  has_many :tags, through: :artifact_tags

  before_create :update_neighborhood_counter_cache
  before_save :update_neighborhood_counter_cache

  scope :near, -> (latitude, longitude, distance_in_meters = 250) {
    where(%{
      ST_DWithin(
        ST_GeographyFromText(
          'SRID=4326;POINT(' || artifacts.longitude || ' ' || artifacts.latitude || ')'
        ),
        ST_GeographyFromText('SRID=4326;POINT(%f %f)'),
        %d
      )
    } % [longitude, latitude, distance_in_meters])
    .order(%{
      'SRID=4326;POINT(' || artifacts.longitude || ' ' || artifacts.latitude || ')' <->
      'SRID=4326;POINT(%f %f)'
    } % [longitude, latitude])
  }

  scope :contained_within, -> (geom) {
    where(%{
      ST_Within(
        ST_GeomFromText(
          'SRID=4326;POINT(' || artifacts.longitude || ' ' || artifacts.latitude || ')'
        ),
        '%s'
      )
    } % [geom])
  }

  def neighbors(radius=nil)
    if radius
      Artifact.near(self.latitude, self.longitude, radius)
    else
      Artifact.near(self.latitude, self.longitude)
    end
  end

  def neighborhood
    Neighborhood.containing(self.latitude, self.longitude).first if self.latitude && self.longitude
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
      picture_count: self.pictures.count,
      map_thumb: image.map_thumb.url,
      info_thumb: image.map_show.url,
      show_url: "/artifacts/#{self.id}"
    }
  end

  def self.all_with_picture
    # this could be optimized
    self.all.select { |a| a.pictures.count > 0 }
  end

  def post_311_request
    uri = URI.parse('http://test311request.cityofchicago.org/open311/v2/requests.json')

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data({'api_key' => 'b8c991cbe23fb49180b59c8744d24824',
                           'service_code'=> '4fd3b167e750846744000005',
                           'lat' => self.latitude.to_f,
                           'long'=> self.longitude.to_f,
                           'address_string' => "123 Test Street",
                           'description' => "Test description, Leon strikes again",
                           'attribute[WHEREIS1]'=> "FRONT",
                           'attribute[WHATTYP2]'=> "UNK",
                           'attribute[OVER6FEE]' => 'NO'})

    response = http.request(request)
    msg = response.body
    # binding.pry
    JSON.parse(msg).pop["token"]
  end

  def request_status
    uri = URI.parse("http://test311request.cityofchicago.org/open311/v2/requests/#{self.open311_token}.json")

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    msg = response.body
    #binding.pry
    JSON.parse(msg)
  end

  private

  def update_neighborhood_counter_cache
    if neighborhood = self.neighborhood
      neighborhood.update_cache
    end
  end
end
