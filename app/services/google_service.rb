class GoogleService
  def initialize(location)
    @city = location.address
    @latitude = location.latitude
    @longitude = location.longitude
  end

  def get_json_coords
    response = conn.get('json', address: @city)
    JSON.parse(response.body, symbolize_names: true)
  end

  def coordinates
    location_hash = get_json_coords
    location_hash[:results][0][:geometry][:location]
  end

  def get_json_address
    response = conn.get('json', latlng: "#{@latitude},#{@longitude}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def address
    address_hash = get_json_address
    address_hash[:results][0][:formatted_address]
  end

  private

  def conn
    key = ENV['GOOGLE_API_KEY']
    Faraday.new('https://maps.googleapis.com/maps/api/geocode', params: {key: key})
  end
end
