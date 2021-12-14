def parse_data(filename)
  result = []
  file = File.open(filename)
  file.readlines(chomp: true).each do |line|
    result << line.match(/(?<a>[a-zA-Z]+)-(?<b>[a-zA-Z]+)/)
  end
  file.close()
  result
end