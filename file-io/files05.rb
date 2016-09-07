# Conflicting writes. Who wins?

write_file_1 = File.new("./conflict.txt", "a+")
write_file_2 = File.new("./conflict.txt", "a+")

write_file_1.write("HAHA")
write_file_2.write("OHNO")

write_file_2.flush()
write_file_1.flush()

