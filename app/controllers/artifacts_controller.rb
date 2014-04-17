class ArtifactsController < ApplicationController
  def index
    @artifacts = Artifact.all_with_picture
  end

  def explore
    @artifacts = Artifact.all
  end

  def new
  end

  def create
  end

  def show
    @artifact = Artifact.find(params[:id])
  end

  def update
  end

  def upvote
    @artifact = Artifact.find(params[:artifact_id])
    @artifact.votes += 1
    @artifact.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def downvote
    @artifact = Artifact.find(params[:artifact_id])
    @artifact.votes -= 1
    @artifact.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
