require 'rails_helper'

describe "GET /api/v1/backgrounds" do
  it "provides a new background image for a specific city" do
    VCR.use_cassette("background_image_by_location") do
      get '/api/v1/backgrounds?location=denver,co'

      expect(response).to be_successful

      data = JSON.parse(response.body)
      keys = [
          "id",
          "description",
          "alt_description",
          "raw_url",
          "full_url",
          "city"
      ]
      expect(data["data"]["attributes"].keys).to eq(keys)
    end
  end

  it "finds an already existing image if the location has one" do
    location = Location.create(address: "denver,co", latitude: 39.7392358, longitude: -104.990251)
    image = BackgroundImage.create(
                                  location: location,
                                  description: "Picture",
                                  alt_description: "Pic of Denver",
                                  raw_url: "random_image.jpg",
                                  full_url: "full_random_image.jpg",
                                  city: "Denver"
                                )

    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful

    data = JSON.parse(response.body)
    keys = [
        "id",
        "description",
        "alt_description",
        "raw_url",
        "full_url",
        "city"
    ]
    expect(data["data"]["attributes"].keys).to eq(keys)
  end
end
