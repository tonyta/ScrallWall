class Reflection < ActiveRecord::Base
  belongs_to :user
  belongs_to :artifact

  has_many :votes, as: :votable
  has_many :flags, as: :flaggable

  validates :text, presence: true
  validates :text, length: {minimum: 1}

end
