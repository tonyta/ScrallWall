class User < ActiveRecord::Base
  has_many :favs
  has_many :favorites, through: :favs, source: :artifact_id

  has_many :artifact_tags

  has_many :pictures
  has_many :reflections

  has_many :votes
  has_many :flags


  validates :username, presence: true
  validates :username, uniqueness: true
  validates :first_name, presence: true
  validates :first_name, length: {in: 2..12}
  validates :last_name, length: {in: 2..12}
  validates :email, presence: true
  validates :email, format: {with: /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/, message: "Please introduce a valid email" }
  validates :email, uniqueness: true
  validates :bio, length: {maximum: 100}



end
