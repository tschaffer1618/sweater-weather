class Antipode
  attr_reader :id,
              :search_city,
              :antipode_city,
              :current_status,
              :current_temp

  def initialize(search_city, antipode_city, forecast)
    @id = rand(1000..9999)
    @search_city = search_city
    @antipode_city = antipode_city
    @current_status = forecast.current_status
    @current_temp = forecast.current_temp
  end
end
