require 'spec_helper'

describe LocationsController do
  describe "locations/new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end
end