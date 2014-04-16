class NeighborhoodsController < ApplicationController
  def index
  end

  def show
    #raise params.inspect
    #@artifacts = Artifact.all
    neighborhood = Neighborhood.find(params[:id]).pri_neigh
    @artifacts = Artifact.bullshit(neighborhood)

    raise @artifacts.inspect


    #raise @neighborhood.inspect
  end

  def all
    neighborhoods = Neighborhood.all.map(&:to_geojson)
    render json: neighborhoods
  end

  def find
    lat, lng = params[:lat].to_f, params[:lng].to_f
    neighborhood = Neighborhood.containing(lat, lng)[0]
    neighborhood_coords = neighborhood ? neighborhood.to_geojson : nil
    render json: neighborhood_coords
  end
end
