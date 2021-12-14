#! /usr/bin/env ruby
total = 0
prev = nil
x = 0
depth = 0
$stdin.each_line do |line|
  line = line.chomp
  match_data = /^(?<direction>[a-z]+) (?<amount>\d+)$/.match(line)
  direction = match_data[:direction]
  amount = match_data[:amount].to_i
  case direction
  when "forward" then x += amount
  when "down" then depth += amount
  when "up" then depth -= amount
  end
end
puts x * depth
