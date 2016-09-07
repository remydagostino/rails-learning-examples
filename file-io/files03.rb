# Read the end of the file, as it becomes available

file = File.new("./testfile.txt", "r")
reading = true

trap("INT") {
  reading = false
  file.close()
}

file.seek(0, IO::SEEK_END)

while reading do
  line = file.gets()

  if !line.nil? then
    puts "got line: #{line}"
  end

  sleep 0.5
end

# tail -f testfile.txt
