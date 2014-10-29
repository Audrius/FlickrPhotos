class HomeController < ApplicationController
    
  def welcome
    @current_page = 1
    @total_photos = 0
  end

  def view_search_settings
  end

  def search_photos
    # Default search string is kitty
    @search_value = params[:search_params]
    @search_value = 'kitty' if @search_value.blank?
    
    params[:page] = '1' if params[:page].blank?
    response = call_flickr_api(@search_value, params[:page])

    @current_page = response['photos']['page']
    @total_pages  = response['photos']['pages']
    @photos_pages = response['photos']['perpage']
    @total_photos = response['photos']['total'].to_i
    @photos       = response['photos']['photo']

    @page_from, @page_to = get_pagination(@current_page, @total_pages)

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

    def generate_url(search_params, page)
      url = "https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1"
      url = add_parameter(url, 'api_key', ENV['MY_FL_KEY'])
      url = add_parameter(url, 'text', CGI::escape(search_params))
      url = add_parameter(url, 'page', page)
      SearchSettings.get_all.each do |key, value|
        url = add_parameter(url, key, value)      
      end
      return url
    end

    def call_flickr_api(search_params, page)
      url = URI.parse(generate_url(search_params, page))
      http = Net::HTTP.new url.host, url.port
      http.use_ssl = true
      response = nil
      http.start do |res|
        response = JSON.parse(res.request_get(url.request_uri).body.to_s)
      end
      return response
    end

    def get_pagination(current_page, total_pages)
      return 1, 9 if (current_page - 4) < 1
      return current_page - 8 + total_pages - current_page, total_pages  if current_page + 4 > total_pages 
      return current_page - 4, current_page + 4
    end
end
