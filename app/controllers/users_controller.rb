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

    url = URI("https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Authorization"] = "Bearer #{token}"
    request["Content-Type"] = "application/json"
    password =
      Base64.strict_encode64(
        "174379bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919#{Time.now.strftime "%Y%m%d%H%M%S"}"
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
      CallBackURL: "https://hired-app-api.herokuapp.com/mpesa_callback",
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

  def pay_mpesa
    url = URI("https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest")
    ​
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    ​
    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/json"
    request["Authorization"] = "Bearer PvjKWATucakNi5BKtacYJVvcQUcq"
    ​
    request.body = {
      BusinessShortCode: code,
      Password:
        "MTc0Mzc5YmZiMjc5ZjlhYTliZGJjZjE1OGU5N2RkNzFhNDY3Y2QyZTBjODkzMDU5YjEwZjc4ZTZiNzJhZGExZWQyYzkxOTIwMjIxMjIxMTMxMjQy",
      Timestamp: "20221221131242",
      TransactionType: "CustomerPayBillOnline",
      Amount: amount,
      PartyA: phone,
      PartyB: code,
      PhoneNumber: phone,
      CallBackURL: "https://mydomain.com/path",
      AccountReference: "NewLife",
      TransactionDesc: "Payment of drugs"
    }
    ​
    response = https.request(request)
    puts response.read_body
  end
end
