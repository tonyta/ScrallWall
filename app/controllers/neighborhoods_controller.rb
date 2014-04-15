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
end
