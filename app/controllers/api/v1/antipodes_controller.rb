class Api::V1::AntipodesController < ApplicationController
  def show
    search_location = update_search_location
    antipode_coords = AmypodeService.new(search_location).get_antipode_coords
    antipode_location = update_antipode_location(antipode_coords)
    forecast_hash = DarkSkyService.new(antipode_location).get_json_forecast
    forecast = Forecast.new(forecast_hash, antipode_location.address)
    antipode = Antipode.new(search_location.address, antipode_location.address, forecast)
    antipode_json = AntipodeSerializer.new(antipode)
    render json: antipode_json
  end

  private

  def update_search_location
    search_location = Location.find_or_create_by(address: params[:location].downcase)
    unless search_location.latitude
      coordinates = GoogleService.new(search_location).coordinates
      search_location.update(latitude: coordinates[:lat], longitude: coordinates[:lng])
    end
    search_location
  end

  def update_antipode_location(antipode_coords)
    antipode_location = Location.find_or_create_by(
                latitude: antipode_coords[:data][:attributes][:lat],
                longitude: antipode_coords[:data][:attributes][:long]
              )
    unless antipode_location.address
      address = GoogleService.new(antipode_location).address
      antipode_location.update(address: address.downcase)
    end
    antipode_location
  end
end
