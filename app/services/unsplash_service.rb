class UnsplashService
  def initialize(location)
    @address = location.address
  end

  def get_json_image
    response = conn.get("random", query: @address)
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    key = ENV['UNSPLASH_API_KEY']
    Faraday.new("https://api.unsplash.com/photos", params: {client_id: key})
  end
end
