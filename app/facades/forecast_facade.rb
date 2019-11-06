class ForecastFacade
  def serialize_forecast(location, address)
    forecast_hash = DarkSkyService.new(location).get_json_forecast
    forecast = Forecast.new(forecast_hash, address)
    ForecastSerializer.new(forecast)
  end
end
