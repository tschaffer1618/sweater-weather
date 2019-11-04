class DarkSkyService
  def initialize(coordinates)
    @latitude = coordinates[:lat]
    @longitude = coordinates[:lng]
  end

  def get_json_forecast
    response = conn.get("#{@latitude},#{@longitude}")
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    key = ENV['DARK_SKY_API_KEY']
    Faraday.new("https://api.darksky.net/forecast/#{key}")
  end
end
