class ArtifactTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :artifact
end
