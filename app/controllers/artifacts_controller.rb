class ArtifactsController < ApplicationController
  def index
    @artifacts = Artifact.all
    @hash = Gmaps4rails.build_markers(@artifacts) do |artifact, marker|
      marker.lat(artifact.latitude)
      marker.lng(artifact.longitude)
    end
  end
end
