class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(JSON.parse(request.body.read))
    render_proper_json(user)
  end

  private 

  def render_proper_json(user)
    if user.save
      key = SecureRandom.hex(27)
      user.update(api_key: key)
      render json: {api_key: key}, status: 201
    else
      render json: {error: "User not created"}, status: 400
    end
  end
end
