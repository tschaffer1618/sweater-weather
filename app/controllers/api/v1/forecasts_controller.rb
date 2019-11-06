class Api::V1::ForecastsController < ApplicationController
  def show
    location = find_or_create_location(params[:location])
    facade = ForecastFacade.new
    forecast_json = facade.serialize_forecast(location, params[:location])
    render json: forecast_json
  end
end
