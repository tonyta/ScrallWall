class ArtifactsController < ApplicationController
  def index
    # #within is a Geokit-rails method
    @artifacts = Artifact.all
    # #within is a Geokit-rails method
    # @artifacts = Artifact.within(5, origin: Artifact.find(1))

    @artifacts.map! do |artifact|
      @first_image = artifact.pictures.first.image
      { lat: artifact.latitude,
        lon: artifact.longitude,
        map_thumb: @first_image.map_thumb.url,
        info_thumb: @first_image.thumb.url
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
