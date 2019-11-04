class AmypodeService
  def initialize(location)
    @latitude = location.latitude
    @longitude = location.longitude
  end

  def get_antipode_coords
    response = Faraday.get('http://amypode.herokuapp.com/api/v1/antipodes') do |req|
      req.params['lat'] = @latitude
      req.params['long'] = @longitude
      req.headers['api_key'] = ENV['AMYPODE_API_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)
  end

end
