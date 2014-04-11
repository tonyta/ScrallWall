class Location < ActiveRecord::Base
  has_many :artifacts
  
  geocoded_by :address
  after_validation :geocode
end
