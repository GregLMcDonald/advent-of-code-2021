def parse_data(filename)
  result = []
  file = File.open(filename)
  file.readlines(chomp: true).each do |line|
    parsed_line = [nil]
    parsed_line << line.split("").map(&:to_i)
    parsed_line << [nil]
    result << parsed_line.flatten
  end
  file.close()
  row_size = result[0].size
  nil_row = Array.new(row_size, nil)
  result << nil_row
  result.unshift(nil_row)
end