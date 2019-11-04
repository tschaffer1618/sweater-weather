class AntipodeSerializer
  include FastJsonapi::ObjectSerializer

  attributes  :id,
              :search_city,
              :antipode_city,
              :forecast

end
