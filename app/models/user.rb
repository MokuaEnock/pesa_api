class User < ApplicationRecord
  before_save :pay_mpesa

  def pay_mpesa
    require "uri"
    require "net/http"
    url = URI("https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/json"
    request["Authorization"] = "Bearer zUGbrVJZTCGm1dvYnfWO1gPlhTaT"
    ​
    request.body = {
      BusinessShortCode: 174_379,
      Password:
        "MTc0Mzc5YmZiMjc5ZjlhYTliZGJjZjE1OGU5N2RkNzFhNDY3Y2QyZTBjODkzMDU5YjEwZjc4ZTZiNzJhZGExZWQyYzkxOTIwMjIxMjIyMTYyMDI3",
      Timestamp: "20221222162027",
      TransactionType: "CustomerPayBillOnline",
      Amount: total,
      PartyA: phone,
      PartyB: 174_379,
      PhoneNumber: phone,
      CallBackURL: "https://mydomain.com/path",
      AccountReference: "CompanyXLTD",
      TransactionDesc: "Payment of X"
    }
    ​
    response = https.request(request)
    puts response.read_body
  end
end
