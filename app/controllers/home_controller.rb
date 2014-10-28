class HomeController < ApplicationController
    
  URL_SERVICE = 'https://api.flickr.com/services/rest'
  METHOD = 'flickr.photos.search'
  
  FORMAT = 'json'

  def welcome
  end

  def search_photos
    search_params = params[:search_params]
    
    $my_api_key = ENV['MY_FL_KEY']

    
    url = "#{URL_SERVICE}/?method=#{METHOD}&api_key=#{$my_api_key}&format=json&tags=#{search_params}&nojsoncallback=1&per_page=100&extras=url_z"
    ##?api_key=#{@api_key}&method=#{method}"
    url = URI.parse(url)
    http = Net::HTTP.new url.host, url.port
    http.use_ssl = true
    ap url.request_uri
    response = nil
    http.start do |res|
      response = JSON.parse(res.request_get(url.request_uri).body.to_s)
    end

    puts response


    page = response['photos']['page']
    pages = response['photos']['pages']
    per_pages = response['photos']['perpage']
    total    = response['photos']['total']

    puts "Current results page #{page} pages #{pages} per_pages #{per_pages} total #{total}"

    @photos = []

    response['photos']['photo'].each do | photo |
      ap photo
      
      @photos << photo if  true || photo['width_z'] == "640" && photo['height_z'] == "640" 
    end 
    
    #{"id"=>"15027892464", "owner"=>"125421155@N06", "secret"=>"37dedb5339", "server"=>"7560", "farm"=>8, "title"=>"Поняли, да? У нас персональный электрик. 😸💡#кот #кошки #home #cat #catworld #animal #funnycat #kitty #kitten #littlecat #light #tula #tulacity #russia #pet @bez_kota", "ispublic"=>1, "isfriend"=>0, "isfamily"=>0}

    puts search_params  
    render :welcome
  end

 

end
