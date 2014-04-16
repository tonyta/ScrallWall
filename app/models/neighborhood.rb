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

  def to_geojson
    multipolygon = ActiveRecord::Base.connection.execute(%{
      select ST_AsText(geom) from neighborhoods where gid = %i;
    } % [self.gid]).values.flatten.pop
    parse_to_geojson(multipolygon)
  end

  private

  def parse_to_geojson(multipolygon)
    multipolygon.match(/\(([\d .\-,]*)\)/)[1].split(',').map{|s| s.split(' ').reverse.map(&:to_f) }.to_json
  end
end

# Neighborhood.find_by_pri_neigh('Wrigleyville').to_geojson.match(/\(([\d .\-,]*)\)/)[1].split(',').map{|s| s.split(' ').reverse.map(&:to_f) }.to_json
