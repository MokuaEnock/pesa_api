class JobsController < ApplicationController
  def fetch
    # require "net/http"
    url =
      URI(
        "https://api.adzuna.com/v1/api/jobs/gb/search/1?app_id=d0291057&app_key=e45310af6518f33ea0f2617638ff1d7f"
      )
    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::GET.new(url)

    response = http.request(request)

    render  json: response.body
  end
end
