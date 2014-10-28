class HomeController < ApplicationController
    
  def welcome
  end

  def view_search_settings
  end

  def search_photos
    search_params = params[:search_params]
    
    # Default search
    search_params = 'kitty' if search_params.empty?
    
    url = URI.parse(generate_url(search_params))
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
    puts search_params  
    render :welcome
  end

  def update_search_settings
    SearchSettings.per_page       = params[:per_page]
    SearchSettings.privacy_filter = params[:privacy_filter]
    SearchSettings.safe_search    = params[:safe_search]
    SearchSettings.content_type   = params[:content_type]
    flash[:settings_saved] = "Settings saved!"
    redirect_to :root
  end

  private 
    def add_parameter(url, parameter_name, parameter_value)
      url = "#{url}&#{parameter_name}=#{parameter_value}"
    end

    def generate_url(search_params)
      url = "https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1"
      url = add_parameter(url, 'api_key', ENV['MY_FL_KEY'])
      url = add_parameter(url, 'text', search_params)  
      SearchSettings.get_all.each do |key, value|
        url = add_parameter(url, key, value)      
      end
      return url
    end
end
