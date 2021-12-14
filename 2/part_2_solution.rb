#! /usr/bin/env ruby
total = 0
prev = nil
horizontal = 0
depth = 0
aim = 0
$stdin.each_line do |line|
  line = line.chomp
  match_data = /^(?<direction>[a-z]+) (?<amount>\d+)$/.match(line)
  direction = match_data[:direction]
  amount = match_data[:amount].to_i
  case direction
  when "down" then aim += amount
  when "up" then aim -= amount
  when "forward"
    horizontal += amount
    depth += amount * aim
  end
end
puts horizontal * depth
