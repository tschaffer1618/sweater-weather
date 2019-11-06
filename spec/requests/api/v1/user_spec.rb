require 'rails_helper'

describe "POST /api/v1/users" do
  it "creates a new user with an api key if the request has the correct info" do
    params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    post '/api/v1/users', params: params.to_json

    expect(response.status).to eq 201
    expect(response.body).to include 'api_key'
  end

  it "returns an error message if the request has incorrect info" do
    params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "123"
    }
    post '/api/v1/users', params: params.to_json

    expect(response.status).to eq 400
    expect(response.body).to include 'User not created'
  end
end
