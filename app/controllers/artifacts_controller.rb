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

  def update
    # @artifact = Artifact.find(params[:id])
    # if params[:vote] == 'upvote'
    #   artifact.votes += 1
    # elsif params[:vote] == 'downvote'
    #   artifact.votes -= 1
    # end
  end

  def upvote
    @artifact = Artifact.find(params[:artifact_id])
    @artifact.votes += 1
    @artifact.save
    render nothing: true
  end

  def downvote
    @artifact = Artifact.find(params[:artifact_id])
    @artifact.votes -= 1
    @artifact.save
    render nothing: true
  end
end
