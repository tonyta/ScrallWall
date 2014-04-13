require 'carrierwave/orm/activerecord'

class Picture < ActiveRecord::Base
  belongs_to :user
  belongs_to :artifact

  has_many :votes
  has_many :flags, as: :flaggable

  mount_uploader :image, ImageUploader
end
