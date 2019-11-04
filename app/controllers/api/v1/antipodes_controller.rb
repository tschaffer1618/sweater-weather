class Api::V1::AntipodesController < ApplicationController
  def show
    facade = AntipodeFacade.new(params[:location])
    antipode_json = facade.return_antipode_json
    render json: antipode_json
  end
end
