require 'rails_helper'

describe GoogleService do
  before(:each) do
    @location_1 = Location.create(address: "Denver,CO")
    @google_service_1 = GoogleService.new(@location_1)
  end

  it "exists" do
    expect(@google_service_1).to be_a(GoogleService)
  end

  it "#get_json_coords" do
    VCR.use_cassette("google_service_raw") do
      json_response = @google_service_1.get_json_coords
      expect(json_response[:status]).to eq "OK"
      expect(json_response[:results][0][:address_components][0][:long_name]).to eq "Denver"
    end
  end

  it "#coordinates" do
    VCR.use_cassette("google_service_coordinates") do
      coordinates = @google_service_1.coordinates
      expect(coordinates[:lat]).to eq 39.7392358
      expect(coordinates[:lng]).to eq -104.990251
    end
  end
end
