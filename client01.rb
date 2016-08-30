require "net/http"
require "json"

uri = URI("http://localhost:3001")

Net::HTTP.start(uri.host, uri.port) do |http|
  response = http.request_get(uri)

  puts response.code
  puts response.body
end

