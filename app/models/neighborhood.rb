class Neighborhood < ActiveRecord::Base
  has_many :artifacts

   validates :name, inclusion: { in: %w(logan_square downtown wicker_park),
    message: "%{neigborhood} is not a valid hood, bro" }

end
