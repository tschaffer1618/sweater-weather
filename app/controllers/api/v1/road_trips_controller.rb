class Api::V1::RoadTripsController < ApplicationController
  def create
    info = JSON.parse(request.body.read)
    origin = info["origin"]
    destination = info["destination"]
    api_key = info["api_key"]
    user = User.find_by(api_key: api_key)
    if user
      destination_location = Location.find_or_create_by(address: destination.downcase)
      unless destination_location.latitude
        coordinates = GoogleService.new.address_coordinates(destination)
        destination_location.update(latitude: coordinates[:lat], longitude: coordinates[:lng])
      end
      travel_time = GoogleService.new.road_trip_time(origin, destination)
      service = DarkSkyService.new(destination_location)
      forecast_basics = service.future_hour_summary(travel_time)
      final_hash = {
        travel_time: "#{travel_time} hours",
        forecast: forecast_basics
      }
      render json: final_hash.to_json, status: 200
    else
      render json: {error: "Unauthorized"}, status: 401
    end
  end
end