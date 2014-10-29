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
    it "should allow to change settings" do
      post :update_search_settings, per_page: 50
      expect(SearchSettings.per_page).to eql "50"
      expect(subject).to redirect_to(:root)
    end
  end

  describe "Search action" do
    it "should allow very simple search" do
      get :search_photos, search_params: 'car'
      expect(response).to have_http_status(:success)
    end
    it "allows to write multiply strings" do
      get :search_photos, search_params: 'cat kitty'
      expect(response).to have_http_status(:success)
    end
  end

  describe "Page pagination" do
    it "should calculate right page from and to numbers" do
      expect(subject.instance_eval{get_pagination(5, 30)}).to eql [1, 9]
      expect(subject.instance_eval{get_pagination(10, 30)}).to eql [6, 14]
      expect(subject.instance_eval{get_pagination(29, 30)}).to eql [22, 30]
    end
  end
end
