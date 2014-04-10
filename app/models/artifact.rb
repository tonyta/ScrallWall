class Artifact < ActiveRecord::Base
  belongs_to :neighborhood

  has_many :pictures
  has_many :reflections

  has_many :artifact_tags
  has_many :tags, through: :artifact_tags

  has_many :favs
  has_many :favoritors, through: :favs, source: :user_id

  validates :geotag, presence:true
end
