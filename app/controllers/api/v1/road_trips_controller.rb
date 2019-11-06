class Api::V1::RoadTripsController < ApplicationController
  def create
    info = JSON.parse(request.body.read)
    origin = info["origin"]
    destination = info["destination"]
    api_key = info["api_key"]
    user = User.find_by(api_key: api_key)
    render_proper_json(user, origin, destination)
  end

  private

  def render_proper_json(user, origin, destination)
    if user
      destination_location = find_or_create_location(destination)
      facade = RoadTripFacade.new
      road_trip_json = facade.serialize_road_trip(origin, destination, destination_location)
      render json: road_trip_json, status: 200
    else
      render json: {error: "Unauthorized"}, status: 401
    end
  end
end
