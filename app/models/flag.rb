class Flag < ActiveRecord::Base
  belongs_to :user
  belongs_to :flaggable, polymorphic: true
end
