require 'rails_helper'

describe "GET /api/v1/antipodes" do
  it "provides an antipode for a specific city" do
    VCR.use_cassette("antipode_by_location") do
      get '/api/v1/antipodes?location=hong kong'

      expect(response).to be_successful

      data = JSON.parse(response.body)
      keys = [
          "id",
          "search_city",
          "antipode_city",
          "current_status",
          "current_temp"
      ]
      expect(data["data"]["attributes"].keys).to eq(keys)
    end
  end
end
