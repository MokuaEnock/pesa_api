class User < ApplicationRecord
  require "uri"
  require "net/http"
  url = URI("https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest")

  before_save :pay_mpesa

  def pay_mpesa
    ​
    ​
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    ​
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
      Amount: 1,
      PartyA: 254_708_374_149,
      PartyB: 174_379,
      PhoneNumber: 254_708_374_149,
      CallBackURL: "https://mydomain.com/path",
      AccountReference: "CompanyXLTD",
      TransactionDesc: "Payment of X"
    }
    ​
    response = https.request(request)
    puts response.read_body
  end
end
