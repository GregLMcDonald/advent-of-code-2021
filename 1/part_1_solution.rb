#! /usr/bin/env ruby
total = 0
prev = nil
$stdin.each_line do |line|
  value = line.chomp.to_f
  total += 1 if !prev.nil? && value > prev
  prev = value
end
puts total