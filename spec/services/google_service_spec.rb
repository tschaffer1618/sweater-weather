require 'rails_helper'

describe GoogleService do
  before(:each) do
    @city = "Denver,CO"
    @google_service = GoogleService.new(@city)
  end

  it "exists" do
    expect(@google_service).to be_a(GoogleService)
  end

  it "#get_json_response" do
    VCR.use_cassette("google_service_raw") do
      json_response = @google_service.get_json_response
      expect(json_response[:status]).to eq "OK"
      expect(json_response[:results][0][:address_components][0][:long_name]).to eq "Denver"
    end
  end

  it "#coordinates" do
    VCR.use_cassette("google_service_coordinates") do
      coordinates = @google_service.coordinates
      expect(coordinates[:lat]).to eq 39.7392358
      expect(coordinates[:lng]).to eq -104.990251
    end
  end
end
