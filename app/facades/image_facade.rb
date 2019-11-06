class ImageFacade
  def serialize_image(address)
    location = Location.find_or_create_by(address: address.downcase)
    if location.background_image
      image = location.background_image
    else
      image = create_image(location)
    end
    ImageSerializer.new(image)
  end

private

  def create_image(location)
    json_image = UnsplashService.new(location).get_json_image
    image = BackgroundImage.create(location: location,
                  description: json_image[:description],
                  alt_description: json_image[:alt_description],
                  raw_url: json_image[:urls][:raw],
                  full_url: json_image[:urls][:full],
                  city: json_image[:location][:city]
                )
  end
end
