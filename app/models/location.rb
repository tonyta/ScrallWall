class Location < ActiveRecord::Base
  belongs_to :artifact
  
  geocoded_by :address
  after_validation :geocode
end
