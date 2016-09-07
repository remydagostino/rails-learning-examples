# Read the file one line at a time

file = File.new("./testfile.txt", "r")
reading = true

while reading do
  line = file.gets()

  if !line.nil? then
    puts "Got a line: #{line}"
  else
    reading = false
    file.close()
  end

  sleep 0.5
end

# cat file.txt
