class ApplicationController < ActionController::API
  def find_or_create_location(location_address)
    location = Location.find_or_create_by(address: location_address.downcase)
    unless location.latitude
      coordinates = GoogleService.new.address_coordinates(location_address)
      location.update(latitude: coordinates[:lat], longitude: coordinates[:lng])
    end
    location
  end
end
