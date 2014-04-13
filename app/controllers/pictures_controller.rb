class PicturesController < ApplicationController

  def new
    @picture = Picture.new
  end

  def create
    image = params[:picture][:image].tempfile

    redirect_to new_picture_path and return unless image

    latitude, longitude = get_lat_long(image)

    p '-'*48
    p "latitude: #{latitude}"
    p "longitude: #{longitude}"
    p '-'*48
    @picture = Picture.create
    @picture.image = params[:picture][:image]
    @picture.save!

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

  private

  def get_lat_long(image)
    if exif = EXIFR::JPEG.new(image).gps
      latitude = exif.latitude
      longitude = exif.longitude
    else
      latitude = params[:picture][:latitude]
      longitude = params[:picture][:longitude]
    end
    [latitude, longitude]
  end
end
