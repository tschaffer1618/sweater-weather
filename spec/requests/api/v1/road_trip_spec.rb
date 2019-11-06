require 'rails_helper'

describe "POST /api/v1/road_trip" do
  before(:each) do
    @user = User.create(
      email: "whatever@example.com",
      password: "123",
      password_confirmation: "123",
      api_key: "abcd1234"
    )
  end

  it "returns the travel time and forecast summary at arrival time" do
    VCR.use_cassette("road_trip") do
      params = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "abcd1234"
      }
      post '/api/v1/road_trip', params: params.to_json

      expect(response.status).to eq 200
      expect(JSON.parse(response.body).keys).to eq(["travel_time", "forecast"])
    end
  end

  it "returns an error if a wrong api key is sent" do
    params = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": "wrong"
    }
    post '/api/v1/road_trip', params: params.to_json

    expect(response.status).to eq 401
  end
end
