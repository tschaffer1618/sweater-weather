require 'rails_helper'

describe DarkSkyService do
  before(:each) do
    @location = Location.create(address: "Denver,CO", latitude: 39.7392358, longitude: -104.990251)
    @dark_sky_service = DarkSkyService.new(@location)
  end

  it "exists" do
    expect(@dark_sky_service).to be_a(DarkSkyService)
  end

  it "#get_json_forecast" do
    VCR.use_cassette("dark_sky_service_forecast") do
      json_response = @dark_sky_service.get_json_forecast
      keys = [:latitude, :longitude, :timezone, :currently, :minutely, :hourly, :daily, :flags, :offset]
      expect(json_response.keys).to eq(keys)
    end
  end
end
