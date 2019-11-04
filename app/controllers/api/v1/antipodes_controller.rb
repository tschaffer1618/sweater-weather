class Api::V1::AntipodesController < ApplicationController
  def show
    #find lat and lng (for hong kong) using google service
    location = Location.find_or_create_by(address: params[:location].downcase)
    unless location.latitude
      coordinates = GoogleService.new(params[:location]).coordinates
      location.update(latitude: coordinates[:lat], longitude: coordinates[:lng])
    end
    #use these coords to find antipode lat and lng using amypode api
    antipode_coords = AmypodeService.new(location).get_antipode_coords
    #find the name of the antipode city using google service (backwards)
    #find current weather for antipode city using coords from step 2
    #return json with search city, antipode city, and antipode city forecast
  end

end
