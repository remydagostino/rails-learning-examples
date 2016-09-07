# Replace all of one string with another in a file

readFile = File.new("./testfile.txt", "r")
writeFile = File.new("./testfile.tmp.txt", "w")

replace_this = ARGV[0] || "test"
replace_with = ARGV[1] || "floop"

working = true

# Create the copy with replaced parts
while working do
  line = readFile.gets()

  if !line.nil? then
    writeFile.write(line.gsub(replace_this, replace_with))
    writeFile.flush()
  else
    working = false
    readFile.close()
    writeFile.close()
  end

  sleep 0.01
end

# Copy the temp file back into the original file

tempFile = File.new("./testfile.tmp.txt", "r")
destFile = File.new("./testfile.txt", "w")

working = true

# Copy back to the dest file
while working do
  line = tempFile.gets()

  if !line.nil? then
    destFile.write(line)
    destFile.flush()
  else
    working = false
    tempFile.close()
    destFile.close()
  end

  sleep 0.01
end

File.delete("./testfile.tmp.txt")

