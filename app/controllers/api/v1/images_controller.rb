class Api::V1::ImagesController < ApplicationController
  def show
    facade = ImageFacade.new
    image_json = facade.serialize_image(params[:location])
    render json: image_json
  end
end
