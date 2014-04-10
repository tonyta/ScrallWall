class ArtifactTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :artifact
  belongs_to :user
end
