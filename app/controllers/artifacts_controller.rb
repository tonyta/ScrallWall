class ArtifactsController < ApplicationController
  def index
    @artifacts = Artifact.within(5, origin: Artifact.find(1))

    # @hash = Gmaps4rails.build_markers(@artifacts) do |artifact, marker|
    #   marker.lat(artifact.latitude)
    #   marker.lng(artifact.longitude)
    # end

    @hash = []

    @artifacts.each do |artifact|
      image = artifact.pictures.first.image
      node = {}
      node[:lat] = artifact.latitude
      node[:lng] = artifact.longitude
      node[:picture] = {
        url: "#{image.map_thumb.url}",
        width: 24, height: 24
      }
      node[:infowindow] = "<img src='#{image.thumb.url}'>"
      @hash << node
    end

    # @hash = [{:lat=>41.9245916666667,
    #           :lng=>-87.7001111111111,
    #           picture: {
    #             url: "/uploads/picture/thumb_478b2761-fe74-4b66-8df3-c850e3a0477d.JPG",
    #             width: 90,
    #             height: 120
    #           },
    #           infowindow: "<img src='/uploads/picture/preview_478b2761-fe74-4b66-8df3-c850e3a0477d.JPG'>"
    #          }, {:lat=>41.9245083333333, :lng=>-87.6998833333333}]


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
