class Api::V1::ForecastController < ApplicationController
  def show
    coordinates = GoogleService.new(params[:location]).coordinates
    forecast_hash = DarkSkyService.new(coordinates).get_json_forecast
    forecast = Forecast.new(forecast_hash, params[:location])
    forecast_json = ForecastSerializer.new(forecast)
    render json: forecast_json
  end
end
