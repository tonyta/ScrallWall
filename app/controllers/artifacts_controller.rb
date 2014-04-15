class ArtifactsController < ApplicationController
  def index
    @artifacts = Artifact.all_with_picture
  end

  def explore
  end

  def new
  end

  def create
  end

  def show
    @artifact = Artifact.find(params[:id])
    # @neigborhood = Neighborhood.find_by_sql("SELECT pri_neigh FROM neighborhoods WHERE ST_Contains(geom, ST_GeomFromText('POINT(#{@artifact.longitude} #{@artifact.latitude})', 4326))")
    # @neighborhood = Neighborhood.around()
    @artifact.neighborhood
  end
end
