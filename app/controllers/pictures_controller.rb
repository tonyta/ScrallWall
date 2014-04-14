class PicturesController < ApplicationController
  def new
    @picture = Picture.new
  end

  def create
    image = params[:picture][:image].tempfile

    redirect_to new_picture_path and return unless image

    @latitude, @longitude = get_lat_long(image)

    @picture = Picture.create
    @picture.image = params[:picture][:image]
    @picture.save!

    @nearby_artifacts = Artifact.near(@latitude, @longitude)

    @canonical_pictures = @nearby_artifacts.map(&:canonical_picture)

    render 'edit'
  end

  def neighbors
    lat, lng = params[:lat], params[:lng]

    neighbors = Artifact.near(lat, lng).map do |artifact|
      {id: artifact.id, pictureUrl: artifact.canonical_picture.image.thumb.url}
    end

    render json: neighbors
  end

  def update
    artifact_id = params[:artifact_id]

    if params[:picture]
      latitude, longitude = params[:picture][:latitude], params[:picture][:longitude]
    end

    artifact = Artifact.find_by_id(artifact_id) ||
               Artifact.create!(latitude: latitude, longitude: longitude)

    picture = Picture.find(params[:picture_id] || params[:id])

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
      # gps coords from browser
      latitude = params[:picture][:latitude]
      longitude = params[:picture][:longitude]
    end
    [latitude, longitude]
  end
end
