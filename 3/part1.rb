#! /usr/bin/env ruby
tally = Array.new(12, 0)
nb_lines = 0
$stdin.each_line do |line|
  nb_lines += 1
  data = line.chomp.split("").map(&:to_i)
  data.each_with_index { |value, index| tally[index] += value }
end
gamma_raw = tally.map { |elem| 2 * elem >= nb_lines ? "1" : "0" }
epsilon_raw = gamma_raw.map { |elem| elem == "1" ? "0" : "1" }
gamma = gamma_raw.join().to_i(2) # convert string to integer assume string is in base 2
epsilon = epsilon_raw.join().to_i(2)
puts gamma * epsilon
