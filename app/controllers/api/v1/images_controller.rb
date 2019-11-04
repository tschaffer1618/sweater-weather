class Api::V1::ImagesController < ApplicationController
  def show
    location = Location.find_or_create_by(address: params[:location].downcase)
    if location.background_image
      image = location.background_image
    else
      json_image = UnsplashService.new(location).get_json_image
      image = BackgroundImage.create(location: location,
                    description: json_image[:description],
                    alt_description: json_image[:alt_description],
                    raw_url: json_image[:urls][:raw],
                    full_url: json_image[:urls][:full],
                    city: json_image[:location][:city]
                  )
    end
    render json: ImageSerializer.new(image)
  end
end
