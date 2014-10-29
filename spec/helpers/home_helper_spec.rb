require 'rails_helper'

RSpec.describe HomeHelper, :type => :helper do
  describe "Photo URL" do
    it "should return valid URI" do
      photo = {'server' => '3901', 'farm' => '4', 'secret' => 'db854383c1', 'id' => '15400818691'}
      size = 'c'
      url = URI.parse(get_photo_url(photo, size))
      req = Net::HTTP.new(url.host, url.port)
      req.use_ssl = true
      res = req.request_head(url.path)
      expect(res.code).to eql "200"
    end
  end
end
