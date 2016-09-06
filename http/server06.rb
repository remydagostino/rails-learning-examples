require "webrick"
require "json"

$my_data = {
  "delicious_things" => [
    "tofu",
    "broccoli",
    "candy"
  ],
  "life" => {
    "meaning" => {
      "answer" => 42,
      "question" => "???"
    },
    "origin" => "unknown"
  }
}

def find_in_struct(struct, path)
  if path.length == 0 then
    struct
  elsif struct.has_key? path[0]
    find_in_struct(struct[path[0]], path[1..-1])
  else
    nil
  end
end

class MyServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET (request, response)
    split_path = request.path.split("/").reject do |x| x.length == 0 end
    data = find_in_struct($my_data, split_path)

    if data.nil? then
      response.status = 404
    else
      response.status = 200
      response.content_type = "application/json"
      response.body = JSON.generate(data)
    end
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
      begin
        $my_data = JSON.parse(request.body)

        response.status = 200
        response.content_type = "application/json"
        response.body = JSON.generate($my_data)
      rescue
        response.status = 400
      end
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
# curl localhost:3001 -X POST --header "Authorization: open_seasame" -d '{ "num_bottles": 99 }'

