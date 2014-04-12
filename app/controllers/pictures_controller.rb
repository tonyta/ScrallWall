class PicturesController < ApplicationController

  def new
    @picture = Picture.new
  end

  def create
    #raise params.inspect
    @picture = Picture.create
    @picture.image = params[:picture][:image]
    @picture.save!

    # unless available in EXIF of photo
      latitude = params[:picture][:latitude]
      longitude = params[:picture][:longitude]
    # end

    radius = 0.50
    @artifact = Artifact.new(longitude: longitude, latitude: latitude)
    @nearby_artifacts = Artifact.within(radius, origin: @artifact)

    @canonical_pictures = @nearby_artifacts.map do |artifact|
      artifact.pictures.first
    end

    render 'edit'
  end

  def update
    raise params.inspect
  end

  def destroy
  end

end
