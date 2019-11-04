require 'rails_helper'

describe "GET /api/v1/backgrounds" do
  it "provides a background image for a specific city" do
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
end
