class User < ActiveRecord::Base
  has_many :favs
  has_many :favorites, through: :favs, source: :artifact_id

  has_many :artifact_tags

  has_many :pictures
  has_many :reflections

  has_many :votes
  has_many :flags
end
