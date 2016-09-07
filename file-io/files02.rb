# Read the file one line at a time

file = File.new("./testfile.txt", "r")
reading = true

while reading do
  line = file.gets()

  if !line.nil? then
    puts "Got a error: #{line}" if line=~/error/
  else
    reading = false
    file.close()
  end

  sleep 0.1
end

# cat file.txt
