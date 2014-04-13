class PicturesController < ApplicationController
  def new
    @picture = Picture.new
  end

  def create
    image = params[:picture][:image].tempfile

    redirect_to new_picture_path and return unless image

    @latitude, @longitude = get_lat_long(image)

    p '-'*48
    p "latitude: #{@latitude}"
    p "longitude: #{@longitude}"
    p '-'*48
    @picture = Picture.create
    @picture.image = params[:picture][:image]
    @picture.save!

    radius = 0.50
    # this goes away with PostGIS
    @artifact = Artifact.new(longitude: @longitude, latitude: @latitude)
    @nearby_artifacts = Artifact.within(radius, origin: @artifact)

    @canonical_pictures = @nearby_artifacts.map do |artifact|
      artifact.pictures.first
    end

    render 'edit'
  end

  def update
    artifact_id = params[:artifact_id]
    latitude = params[:picture][:latitude]
    longitude = params[:picture][:longitude]

    artifact = Artifact.find_by_id(artifact_id) ||
               Artifact.create!(latitude: latitude, longitude: longitude)

    picture = Picture.find(params[:picture_id] || params[:id])

    artifact.pictures << picture
    binding.pry

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
