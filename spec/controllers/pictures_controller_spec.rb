require 'spec_helper'

describe PicturesController do

  describe "#new" do
    it "it should assign an empty post" do
      picture = double(:picture)
      Picture
        .should_receive(:new)
        .and_return(picture)
      get :new
      expect(assigns(:picture)).to eq picture
    end
  end

  describe "#create" do
    it "should redirect to new picture unless a picture is submitted" do
      picture_params = { "picture" => { "image" => nil }}
      post :create, picture_params
      expect(response).to redirect_to(new_picture_path)
    end
  end
end
