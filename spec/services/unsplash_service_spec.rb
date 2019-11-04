require 'rails_helper'

describe DarkSkyService do
  before(:each) do
    @location = Location.create(address: "Denver,CO", latitude: 39.7392358, longitude: -104.990251)
    @unsplash_service = UnsplashService.new(@location)
  end

  it "exists" do
    expect(@unsplash_service).to be_a(UnsplashService)
  end

  it "#get_json_image" do
    VCR.use_cassette("unsplash_service_image") do
      json_response = @unsplash_service.get_json_image
      expect(json_response.keys).to include(:description)
      expect(json_response.keys).to include(:alt_description)
      expect(json_response.keys).to include(:urls)
      expect(json_response.keys).to include(:location)
    end
  end
end
