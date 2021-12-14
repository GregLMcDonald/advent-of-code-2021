def parse_data(filename)
  result = []
  file = File.open(filename)
  file.readlines(chomp: true).each do |line|
    result << line.split("")
  end
  file.close()
  result
end