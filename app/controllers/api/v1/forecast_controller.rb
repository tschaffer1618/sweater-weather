class Api::V1::ForecastController < ApplicationController
  def show
    location = Location.find_by(address: params[:location])
    unless location
      coordinates = GoogleService.new(params[:location]).coordinates
      location = Location.create(address: params[:location], latitude: coordinates[:lat], longitude: coordinates[:lng])
    end
    forecast_hash = DarkSkyService.new(location).get_json_forecast
    forecast = Forecast.new(forecast_hash, params[:location])
    forecast_json = ForecastSerializer.new(forecast)
    render json: forecast_json
  end
end
