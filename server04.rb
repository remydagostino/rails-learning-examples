require "webrick"
require "json"

class MyServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET (request, response)
    response.status = 200
    response.content_type = "text/plain"
    response.body = "floop dee doopdy"
  end
  def do_POST (request, response)
    if request["Authorization"] != "open_seasame" then
      response.status = 401
      response.content_type = "application/json"

      response.body = JSON.generate({
        :invalid_token => {
          :token => request["Authorization"]
        }
      })
    else
      response.status = 200
      response.content_type = "application/json"

      response.body = JSON.generate({
        :life => {
          :answer => 42
        }
      })
    end
  end
end

server = WEBrick::HTTPServer.new(:Port => 3001)

server.mount("/", MyServlet)

trap("INT") {
  server.shutdown
}

server.start

# curl localhost:3001 -X POST
# curl localhost:3001 -X POST --header "Authorization: magic_token"
# curl localhost:3001 -X POST --header "Authorization: open_seasame"
