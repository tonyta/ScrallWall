class ArtifactsController < ApplicationController
  def index
    @artifacts = Artifact.within(5, origin: Artifact.find(1))

    @hash = Gmaps4rails.build_markers(@artifacts) do |artifact, marker|
      marker.lat(artifact.latitude)
      marker.lng(artifact.longitude)
    end
  end

  def explore
  end

  def new
  end

  def create
  end

  def show
  end
end
