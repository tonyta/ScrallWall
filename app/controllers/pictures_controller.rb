class PicturesController < ApplicationController

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.create
    @picture.image = params[:picture][:image]
    @picture.save!
  end

  def destroy
  end

end
