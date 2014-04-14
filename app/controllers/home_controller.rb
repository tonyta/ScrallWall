class HomeController < ApplicationController
  def index
    @pictures = Picture.all.shuffle
  end
end
