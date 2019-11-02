class Api::V1::ForecastController < ApplicationController
  def show
    # make api call to google geocoder with params[:location]
    coordinates = GoogleService.new(params[:location]).coordinates
    render json: coordinates.to_json
    # get the latitude and longitude from the response
    # make api call to darksky api with that latitude and longitude
    # turn response to json (serialize the pertinent info in the response)
    # render json (from the serializer)
  end
end
