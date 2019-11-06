class GoogleService

  def get_json_address(address)
    response = conn.get('geocode/json', address: address)
    JSON.parse(response.body, symbolize_names: true)
  end

  def address_coordinates(address)
    location_hash = get_json_address(address)
    location_hash[:results][0][:geometry][:location]
  end

  def get_json_directions(origin, destination)
    response = conn.get('directions/json', origin: origin, destination: destination)
    JSON.parse(response.body, symbolize_names: true)
  end

  def road_trip_time(origin, destination)
    trip_hash = get_json_directions(origin, destination)
    duration_string = trip_hash[:routes][0][:legs][0][:duration][:text]
    duration_array = duration_string.split
    travel_time = 0
    if duration_array[-2].to_i > 29
      travel_time += 1
    end
    if duration_array.count == 4
      travel_time += duration_array[0].to_i
    end    
  end

  private

  def conn
    key = ENV['GOOGLE_API_KEY']
    Faraday.new('https://maps.googleapis.com/maps/api', params: {key: key})
  end
end
