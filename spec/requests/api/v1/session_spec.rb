require 'rails_helper'

describe "POST /api/v1/sessions" do
  before(:each) do
    @user = User.create(
      email: "whatever@example.com",
      password: "123",
      password_confirmation: "123",
      api_key: "abcd1234"
    )
  end

  it "returns the user's api key if the request has the correct info" do
    params = {
      "email": "whatever@example.com",
      "password": "123"
    }
    post '/api/v1/sessions', params: params.to_json

    expect(response.status).to eq 200
    expect(response.body).to include @user.api_key
  end

  it "returns an error message if the request has incorrect info" do
    params = {
      "email": "whatever@example.com",
      "password": "wrong"
    }
    post '/api/v1/sessions', params: params.to_json

    expect(response.status).to eq 400
    expect(response.body).to include 'User not found'
  end
end
