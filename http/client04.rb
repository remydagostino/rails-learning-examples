# Updates the meaning of life by 1 (requires server05)

require "net/http"
require "json"
require "optparse"

options = {}

# Build up an argument parser
option_parser = OptionParser.new do |opts|
  opts.banner = "I increase the meaning of life! eg client.rb [options]"

  opts.on("--auth AUTH", "Authorization token") do |auth|
    options[:auth] = auth
  end

  opts.on("--increment INC", Numeric, "How much to increment the meaning of life by") do |inc|
    options[:increment] = inc
  end
end

option_parser.parse!

# Validate arguments
if options[:auth].nil? then
  puts option_parser
  exit
end

if options[:increment].nil? then
  options[:increment] = 1
end

uri = URI("http://localhost:3001")
authorization_headers = { "Authorization" => options[:auth] }

Net::HTTP.start(uri.host, uri.port) do |http|
  get_response = http.request_get(uri)

  json_body = JSON.parse get_response.body
  json_body["life"]["meaning"]["answer"] += options[:increment]

  post_response = http.request_post(uri, JSON.generate(json_body), authorization_headers)

  puts post_response.code
  puts post_response.body
end

