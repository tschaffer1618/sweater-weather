class GoogleService
  def initialize(city)
    @city = city
  end

  def get_json_response
    response = conn.get('json', address: @city)
    JSON.parse(response.body, symbolize_names: true)
  end

  def coordinates
    location_hash = get_json_response
    location_hash[:results][0][:geometry][:location]
  end

  private

  def conn
    key = ENV['GOOGLE_API_KEY']
    Faraday.new('https://maps.googleapis.com/maps/api/geocode', params: {key: key})
  end
end
