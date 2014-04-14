class ArtifactsController < ApplicationController
  def index
    @artifacts = Artifact.all

    @artifacts.map! do |artifact|
      @first_image = artifact.pictures.first.image
      { lat: artifact.latitude,
        lon: artifact.longitude,
        map_thumb: @first_image.map_thumb.url,
        info_thumb: @first_image.thumb.url,
        show_url: artifact_path(artifact)
      }
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
