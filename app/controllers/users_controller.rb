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

  private

  def user_params
    params.permit(:email, :username, :total, :phone)
  end

  def pay_mpesa(amount, code, phone)
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
