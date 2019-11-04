class AntipodeSerializer
  include FastJsonapi::ObjectSerializer

  attributes  :id,
              :search_city,
              :antipode_city,
              :current_status,
              :current_temp

end
