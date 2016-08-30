# Updates the server data

require "net/http"
require "json"

uri = URI("http://localhost:3001")
data = JSON.generate({ "stuff" => 123 })
headers = { "Authorization" => "open_seasame" }

Net::HTTP.start(uri.host, uri.port) do |http|
  response = http.request_post(uri, data, headers)

  puts response.code
  puts response.body
end

