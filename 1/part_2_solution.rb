#! /usr/bin/env ruby
total = 0
prev_window = []
$stdin.each_line do |line|
  value = line.chomp.to_i
  if prev_window.size < 3
    prev_window << value
  else
    curr_window = prev_window.last(2)
    curr_window << value
    prev_sum = prev_window.reduce(:+)
    curr_sum = curr_window.reduce(:+)
    total += 1 if curr_sum > prev_sum
    prev_window = curr_window
  end
end
puts total