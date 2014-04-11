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

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
end
