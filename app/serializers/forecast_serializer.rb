class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :id,
              :current_status,
              :current_temp,
              :daily_high_temp,
              :daily_low_temp,
              :location,
              :current_time,
              :feels_like_temp,
              :humidity,
              :visibility,
              :uv_index,
              :hourly_forecast,
              :daily_forecast
end
