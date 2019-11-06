class DarkSkyService
  def initialize(location)
    @latitude = location.latitude
    @longitude = location.longitude
  end

  def get_json_forecast
    response = conn.get("#{@latitude},#{@longitude}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def future_hour_summary(number)
    full_forecast = get_json_forecast
    hour = full_forecast[:hourly][:data][number]
    [hour[:summary], hour[:temperature]]
  end

  private

  def conn
    key = ENV['DARK_SKY_API_KEY']
    Faraday.new("https://api.darksky.net/forecast/#{key}")
  end
end
