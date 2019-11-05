class Api::V1::SessionsController < ApplicationController
  def create
    email = JSON.parse(request.body.read)["email"]
    password = JSON.parse(request.body.read)["password"]
    user = User.find_by(email: email)
    if user && user.authenticate(password)
      render json: {api_key: user.api_key}, status: 201
    else
      render json: {error: "User not found"}, status: 400
    end
  end
end
