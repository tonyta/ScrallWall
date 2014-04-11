class Neighborhood < ActiveRecord::Base
  has_many :artifacts

   validates :name, presence: true

end
