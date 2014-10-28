module HomeHelper
  def get_photo_url(photo)
    return "https://farm#{photo['farm']}.staticflickr.com/#{photo['server']}/#{photo['id']}_#{photo['secret']}_q.jpg"
  end
end
