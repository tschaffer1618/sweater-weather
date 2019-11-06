class RoadTripFacade
  def serialize_road_trip(origin, destination, location)
    travel_time = GoogleService.new.road_trip_time(origin, destination)
    service = DarkSkyService.new(location)
    forecast_basics = service.future_hour_summary(travel_time)
    final_hash = {
      travel_time: "#{travel_time} hours",
      forecast: forecast_basics
    }
    final_hash.to_json
  end
end
