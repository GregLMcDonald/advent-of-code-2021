def parse_data(filename)
  result = []
  file = File.open(filename)
  file.readlines(chomp: true).each do |line|
    padded = [nil]
    padded << line.split("").map(&:to_i)
    padded << nil
    result << padded.flatten
  end
  file.close()
  nil_line = Array.new(result[0].size, nil)
  padded_result = [nil_line]
  result.each { |line| padded_result << line }
  padded_result << nil_line
  padded_result
end