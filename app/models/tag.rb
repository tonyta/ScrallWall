Uclass Tag < ActiveRecord::Base
  has_many :artifact_tags
  has_many :artifacts, through: :artifact_tags

  validates :name, presence:true
end
