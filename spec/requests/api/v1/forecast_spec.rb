require 'rails_helper'

describe "GET /api/v1/forecast" do
  it "provides a forecast for a specific city" do
    VCR.use_cassette("forecast_by_location") do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful

      data = JSON.parse(response.body)
      keys = [
          "id",
          "current_status",
          "current_temp",
          "daily_high_temp",
          "daily_low_temp",
          "location",
          "current_time",
          "feels_like_temp",
          "humidity",
          "visibility",
          "uv_index",
          "hourly_forecast",
          "daily_forecast"
      ]
      expect(data["data"]["attributes"].keys).to eq(keys)
    end
  end
end
