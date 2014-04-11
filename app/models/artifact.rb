class Artifact < ActiveRecord::Base
  belongs_to :neighborhood

  has_many :pictures
  has_many :reflections

  has_many :artifact_tags
  has_many :tags, through: :artifact_tags

  has_many :favs
  has_many :favoritors, through: :favs, source: :user_id

  geocoded_by :address
  after_validation :geocode
end

create_table "artifacts", force: true do |t|
    t.integer  "neighborhood_id"
    t.string   "geotag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id"
    t.float    "latitude"
    t.float    "longitude"
  end
