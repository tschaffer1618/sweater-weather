class Forecast
  attr_reader   :id,
                :current_status,
                :current_temp,
                :daily_high_temp,
                :daily_low_temp,
                :location,
                :current_time,
                :feels_like_temp,
                :humidity,
                :visibility,
                :uv_index,
                :hourly_forecast,
                :daily_forecast

  def initialize(hash, location)
    @id = rand(1000..9999)
    @current_status = hash[:currently][:summary]
    @current_temp = hash[:currently][:temperature]
    @daily_high_temp = hash[:daily][:data][0][:temperatureHigh]
    @daily_low_temp = hash[:daily][:data][0][:temperatureLow]
    @location = location
    @current_time = hash[:currently][:time]
    @feels_like_temp = hash[:currently][:apparentTemperature]
    @humidity = hash[:daily][:data][0][:humidity]
    @visibility = hash[:daily][:data][0][:visibility]
    @uv_index = hash[:daily][:data][0][:uvIndex]
    @hourly_forecast = hash[:hourly][:data]
    @daily_forecast = hash[:daily][:data]
  end
end
