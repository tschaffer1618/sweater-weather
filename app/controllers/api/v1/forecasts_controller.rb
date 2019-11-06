class Api::V1::ForecastsController < ApplicationController
  def show
    location = find_or_create_location(params[:location])
    forecast_hash = DarkSkyService.new(location).get_json_forecast
    forecast = Forecast.new(forecast_hash, params[:location])
    forecast_json = ForecastSerializer.new(forecast)
    render json: forecast_json
  end
end
