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
    @picture = Picture.new
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

    if @artifact.votes.to_i <= -10 && @artifact.is_reported == false
      @artifact.open311_token = @artifact.post_311_request
      @artifact.is_reported = true
      @artifact.save!
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
