class HomeController < ApplicationController
    
  URL_SERVICE = 'https://api.flickr.com/services/rest'
  METHOD = 'flickr.photos.search'
  FORMAT = 'json'

  def welcome
  end

  def view_search_settings
  end

  def search_photos
    search_params = params[:search_params]
    
    $my_api_key = ENV['MY_FL_KEY']


    url = "#{URL_SERVICE}/?method=#{METHOD}&api_key=#{$my_api_key}&format=json&text=#{search_params}&nojsoncallback=1&per_page=48&extras=o_dims"
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

    @current_page = response['photos']['page']
    @total_pages  = response['photos']['pages']
    @photos_pages = response['photos']['perpage']
    @total_photos = response['photos']['total']

    ap @total_photos
    @photos       = response['photos']['photo']
      #ap photo
      #@photos << photo
    #end 
    
    #{"id"=>"15027892464", "owner"=>"125421155@N06", "secret"=>"37dedb5339", "server"=>"7560", "farm"=>8, "title"=>"Поняли, да? У нас персональный электрик. 😸💡#кот #кошки #home #cat #catworld #animal #funnycat #kitty #kitten #littlecat #light #tula #tulacity #russia #pet @bez_kota", "ispublic"=>1, "isfriend"=>0, "isfamily"=>0}

    puts search_params  
    render :welcome
  end

  def update_search_settings
    SearchSettings.photos_per_page = params[:photos_per_page]
    SearchSettings.privacy_filter  = params[:privacy_filter]
    SearchSettings.safe_search     = params[:safe_search]
    SearchSettings.content_type    = params[:content_type]
    flash[:settings_saved] = "Settings saved!"
    redirect_to :root
  end


end
