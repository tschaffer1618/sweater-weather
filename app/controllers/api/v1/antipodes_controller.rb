class Api::V1::AntipodesController < ApplicationController
  def show
    #find lat and lng (for hong kong) using google service
    #use these coords to find antipode lat and lng using amypode api
    #find the name of the antipode city using google service (backwards)
    #find current weather for antipode city using coords from step 2
    #return json with search city, antipode city, and antipode city forecast
  end

end
