# Replace all of one string with another in a file

read_file = File.new("./testfile.txt", "r")
write_file = File.new("./testfile.tmp.txt", "w")

replace_this = ARGV[0] || "test"
replace_with = ARGV[1] || "floop"

working = true

# Create the copy with replaced parts
while working do
  line = read_file.gets()

  if !line.nil? then
    write_file.write(line.gsub(replace_this, replace_with))
    write_file.flush()
  else
    working = false
    read_file.close()
    write_file.close()
  end

  sleep 0.01
end

# Copy the temp file back into the original file

temp_file = File.new("./testfile.tmp.txt", "r")
dest_file = File.new("./testfile.txt", "w")

working = true

# Copy back to the dest file
while working do
  line = temp_file.gets()

  if !line.nil? then
    dest_file.write(line)
    dest_file.flush()
  else
    working = false
    temp_file.close()
    dest_file.close()
  end

  sleep 0.01
end

File.delete("./testfile.tmp.txt")

