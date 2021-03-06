require 'rails_helper'

describe GoogleService do
  before(:each) do
    @city = "Denver,CO"
    @google_service = GoogleService.new
  end

  it "exists" do
    expect(@google_service).to be_a(GoogleService)
  end

  it "#get_json_response" do
    VCR.use_cassette("google_service_raw") do
      json_response = @google_service.get_json_address(@city)
      expect(json_response[:status]).to eq "OK"
      expect(json_response[:results][0][:address_components][0][:long_name]).to eq "Denver"
    end
  end

  it "#coordinates" do
    VCR.use_cassette("google_service_coordinates") do
      coordinates = @google_service.address_coordinates(@city)
      expect(coordinates[:lat]).to eq 39.7392358
      expect(coordinates[:lng]).to eq -104.990251
    end
  end

  it "#get_json_directions"do
    VCR.use_cassette("google_service_directions_raw") do
      origin = "Pueblo, CO"
      json_response = @google_service.get_json_directions(origin, @city)
      expect(json_response[:status]).to eq "OK"
      expect(json_response[:routes][0][:legs][0][:duration][:text]).to eq "1 hour 49 mins"
    end
  end

  it "#road_trip_time" do
    VCR.use_cassette("google_service_travel_time") do
      origin = "Pueblo, CO"
      travel_time = @google_service.road_trip_time(origin, @city)
      expect(travel_time).to eq 2
    end
  end
end
