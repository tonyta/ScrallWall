class PicturesController < ApplicationController

  def new
    @picture = Picture.new
  end

  def create
    # raise params.inspect
    @picture = Picture.create
    @picture.image = params[:picture][:image]
    @picture.save!

    latitude = params[:latitude]
    longitude = params[:longitude]

    radius = 0.5
    # @artifact = Artifact.new(longitude: longitude, latitude: latitude)
    # @nearby_artifacts = Artifact.within(radius, artifact)

    render 'edit'
  end

  def destroy
  end

end
