def read_data(filename)
  result = []
  file = File.open(filename)
  file.readlines(chomp: true).each do |line|
    parts = line.split(" | ")
    signal = parts[0].split(" ").compact
    output = parts[1].split(" ").compact
    signal.each_with_index { |value, index| signal[index] = value.split("").sort.join() }
    output.each_with_index { |value, index| output[index] = value.split("").sort.join() }
    result << { signal: signal, output: output }
  end
  file.close()
  result
end