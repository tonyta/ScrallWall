class ArtifactsController < ApplicationController
  def index
    @artifacts = Artifact.all
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
