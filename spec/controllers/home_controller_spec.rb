require 'rails_helper'

RSpec.describe HomeController, :type => :controller do

  describe "GET welcome" do
    it "returns http success" do
      get :welcome
      expect(response).to have_http_status(:success)
    end
  end

  describe "Search Settings" do

  	it "should show settings window"
  	it "should allow to change settings"

  end

  describe "Seach action" do
  	it "allows to write multiply strings"
  	
  end

end
