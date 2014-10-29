require 'rails_helper'

RSpec.describe HomeController, :type => :controller do

  describe "GET welcome" do
    it "returns http success" do
      get :welcome
      expect(response).to have_http_status(:success)
    end
  end

  describe "Search Settings" do

  	it "should show settings window" do
      get :view_search_settings
      expect(response).to have_http_status(:success)
  	end

    it "should allow to change settings"

  end

  describe "Search action" do
  	
    it "allows to write multiply strings" do
      get :search_photos, search_params: 'cat kitty'
      expect(response).to have_http_status(:success)
    end

  end

end
