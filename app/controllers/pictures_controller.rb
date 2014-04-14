class PicturesController < ApplicationController
  def new
    @picture = Picture.new
  end

  def create
    image = params[:picture][:image]
    redirect_to new_picture_path and return unless image

    @latitude, @longitude = get_lat_long(image.tempfile)
    @picture = Picture.create_with_image(image)

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

    redirect_to artifact_path(artifact)
  end

  def destroy
  end

  private

  def get_lat_long(image)
    begin
      if exif = EXIFR::JPEG.new(image).gps
        lat = exif.latitude
        lng = exif.longitude
      end
    rescue
    end

    lat ||= params[:picture][:latitude]
    lng ||= params[:picture][:longitude]

    lat = 41.879530 if lat == ''
    lng = -87.626953 if lng == ''

    [lat, lng]
  end
end
