# Write a very big file

# "r"  Read-only, starts at beginning of file  (default mode).
# "r+" Read-write, starts at beginning of file.
# "w"  Write-only, truncates existing file
#      to zero length or creates a new file for writing.
# "w+" Read-write, truncates existing file to zero length
#      or creates a new file for reading and writing.
# "a"  Write-only, each write call appends data at end of file.
#      Creates a new file for writing if file does not exist.
# "a+" Read-write, each write call appends data at end of file.
#      Creates a new file for reading and writing if file does
#      not exist.

file = File.new("./testfile.txt", "a")

marker = ARGV[0] || "test"
writing = true

trap("INT") {
  writing = false
  file.close()
}

while writing do
  if !file.closed? then
    file.write(marker + ": " + Time::now().inspect + "\n")
    file.flush()
  end

  sleep 1
end


# echo "Whatevs" > file.txt
