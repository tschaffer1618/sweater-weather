class Api::V1::SessionsController < ApplicationController
  def create
    info = JSON.parse(request.body.read)
    email = info["email"]
    password = info["password"]
    user = User.find_by(email: email)
    if user && user.authenticate(password)
      session[:user_id] = user.id
      render json: {api_key: user.api_key}, status: 200
    else
      render json: {error: "User not found"}, status: 400
    end
  end
end
