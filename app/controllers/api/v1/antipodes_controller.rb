class Api::V1::AntipodesController < ApplicationController
  def show
    #find lat and lng (for hong kong) using google service
    search_location = Location.find_or_create_by(address: params[:location].downcase)
    unless search_location.latitude
      coordinates = GoogleService.new(search_location).coordinates
      search_location.update(latitude: coordinates[:lat], longitude: coordinates[:lng])
    end
    #use these coords to find antipode lat and lng using amypode api
    antipode_coords = AmypodeService.new(search_location).get_antipode_coords
    antipode_location = Location.find_or_create_by(
                latitude: antipode_coords[:data][:attributes][:lat],
                longitude: antipode_coords[:data][:attributes][:long]
              )

    #find the name of the antipode city using google service (backwards)
    unless antipode_location.address
      address = GoogleService.new(antipode_location).address
      antipode_location.update(address: address)
    end

    #find current weather for antipode city using coords from step 2
    forecast_hash = DarkSkyService.new(antipode_location).get_json_forecast
    forecast = Forecast.new(forecast_hash, antipode_location.address)

    #return json with search city, antipode city, and antipode city forecast
    antipode = Antipode.new(search_location.address, antipode_location.address, forecast)
    antipode_json = AntipodeSerializer.new(antipode)
    render json: antipode_json

  end

end