class ArtifactsController < ApplicationController
  def index
    # #within is a Geokit-rails method
    @artifacts = Artifact.within(5, origin: Artifact.find(1))

    @artifacts.map! do |artifact|
      @first_image = artifact.pictures.first.image
      { :lat => artifact.latitude,
        :lng => artifact.longitude,
        :picture => { url: "#{@first_image.map_thumb.url}", width: 24, height: 24 },
        :infowindow => @first_image.thumb.url,
        :id => artifact.id
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
