class HomeController < ApplicationController
  def index
    @picture = Picture.new
  end
end
