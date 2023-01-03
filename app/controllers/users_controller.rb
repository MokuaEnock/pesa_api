class UsersController < ApplicationController
  require "uri"
  require "net/http"

  def index
    render json: User.all
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    user = User.create(user_params)
    render json: user
  end

  def mpesa_index
    token = get_access_token
    passkey = "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919"
    url = URI("https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest")
    short = "174379"

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Authorization"] = "Bearer #{token}"
    request["Content-Type"] = "application/json"
    password =
      Base64.strict_encode64(
        "#{passkey}#{passkey}#{Time.now.strftime "%Y%m%d%H%M%S"}"
      )

    request.body = {
      BusinessShortCode: 174_379,
      Password: password,
      Timestamp: "#{Time.now.strftime "%Y%m%d%H%M%S"}",
      TransactionType: "CustomerPayBillOnline",
      Amount: 100,
      PartyA: params[:phone_number],
      PartyB: 174_379,
      PhoneNumber: params[:phone_number],
      CallBackURL: "https://d193-102-215-78-19.in.ngrok.io/mpesa_callback",
      AccountReference: "Hired LTD",
      TransactionDesc: "Payment of subscription"
    }.to_json

    response = https.request(request)
    render json: response.body
  end

  private

  def user_params
    params.permit(:email, :username, :total, :phone)
  end

  def get_access_token
    url =
      URI(
        "https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials"
      )
    ​
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    ​
    request = Net::HTTP::Post.new(url)
    request[
      "Authorization"
    ] = "Bearer cFJZcjZ6anEwaThMMXp6d1FETUxwWkIzeVBDa2hNc2M6UmYyMkJmWm9nMHFRR2xWOQ=="
    ​
    response = https.request(request)

    data = JSON.parse(response.body)
    data["access_token"]
  end

  def sample
    url =
      URI(
        "https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials"
      )
    ​
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    ​
    request = Net::HTTP::Post.new(url)
    request[
      "Authorization"
    ] = "Bearer cFJZcjZ6anEwaThMMXp6d1FETUxwWkIzeVBDa2hNc2M6UmYyMkJmWm9nMHFRR2xWOQ=="
    ​
    response = https.request(request)
    puts response.read_body
  end
end
