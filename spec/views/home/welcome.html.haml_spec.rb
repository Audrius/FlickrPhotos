require 'rails_helper'

RSpec.describe "home/welcome.html.haml", :type => :view do
  describe 'welcome window' do
    it "should render search form in welcome window" do
      assign(:total_photos, 0)
      render
      expect(rendered).to match /form-horizontal/
    end

    it "should not show any photos if no search performed" do
      assign(:total_photos, 0)
      render
      expect(rendered).not_to match /fancybox/
    end

    it "should show photos if found" do
      assign(:total_photos, 20)
      assign(:page_from, 1)
      assign(:page_to, 9)
      render
      expect(rendered).not_to match /img-responsive/
    end

    it "shows again search parameter in form" do
      assign(:total_photos, 0)
      assign(:search_value, "Audrius")
      render
      expect(rendered).to match /Audrius/
    end
  end
end
