class Api::V1::ForecastsController < ApplicationController
  def show
    location = Location.find_or_create_by(address: params[:location].downcase)
    unless location.latitude
      coordinates = GoogleService.new(params[:location]).coordinates
      location.update(latitude: coordinates[:lat], longitude: coordinates[:lng])
    end
    forecast_hash = DarkSkyService.new(location).get_json_forecast
    forecast = Forecast.new(forecast_hash, params[:location])
    forecast_json = ForecastSerializer.new(forecast)
    render json: forecast_json
  end
end
