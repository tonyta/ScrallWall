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
  end
end
