class PicturesController < ApplicationController

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.create
    @picture.image = params[:picture][:image]
    @picture.save!


    latitude = params[:picture][:latitude]
    longitude = params[:picture][:longitude]


    radius = 0.50
    @artifact = Artifact.new(longitude: longitude, latitude: latitude)
    @nearby_artifacts = Artifact.within(radius, origin: @artifact)

    @canonical_pictures = @nearby_artifacts.map do |artifact|
      artifact.pictures.first
    end

    render 'edit'
  end

  def update
    artifact = Artifact.find_or_create_by_id(params[:artifact_id])

    picture = if params[:picture_id]
                Picture.find(params[:picture_id])
              else
                Picture.find(params[:id])
              end

    artifact.pictures << picture

    redirect_to '/'
  end

  def destroy
  end

end
