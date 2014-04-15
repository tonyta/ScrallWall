require 'spec_helper'

describe ArtifactsController do

  describe "#show" do
    it "renders an artifact" do
      id = "101"
      artifact = double(:artifact)
      Artifact
        .should_receive(:find)
        .with(id)
        .and_return(artifact)

      get :show, :id => id
      expect(assigns(:artifact)).to eq artifact
    end
  end

end
