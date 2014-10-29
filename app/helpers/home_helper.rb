module HomeHelper
  def get_photo_url(photo, size)
    "https://farm#{photo['farm']}.staticflickr.com/#{photo['server']}/#{photo['id']}_#{photo['secret']}_#{size}.jpg"
  end
end
