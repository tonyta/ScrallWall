class LocationsController < ApplicationController

  def index
    @locations = Location.all
    @hash = Gmaps4rails.build_markers(@locations) do |location, marker|
      marker.lat(location.latitude)
      marker.lng(location.longitude)
    end
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.create!(geocode_params)
    redirect_to @location
  end

  def index
    if params[:search].present?
      @locations = Location.near(params[:search], 50, :order => :distance)
    else
      @locations = Location.all
    end
  end

  def show
    @location = Location.find(params[:id])
  end

  private

  def geocode_params
    params.require(:location).permit(:address, :latitude, :longitude)
  end
end
