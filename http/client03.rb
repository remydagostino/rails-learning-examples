# Updates the meaning of life by 1 (requires server05)

require "net/http"
require "json"

uri = URI("http://localhost:3001")
authorization_headers = { "Authorization" => "open_seasame" }

Net::HTTP.start(uri.host, uri.port) do |http|
  get_response = http.request_get(uri)

  json_body = JSON.parse get_response.body
  json_body["life"]["meaning"]["answer"] += 1

  post_response = http.request_post(uri, JSON.generate(json_body), authorization_headers)

  puts post_response.code
  puts post_response.body
end

