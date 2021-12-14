#! /usr/bin/env ruby

require "./read_data"
# result = read_data("test.txt")
result = read_data("data.txt")
# pp result

nb_segments = {
  1 => 2, # unique
  7 => 3, # unique
  4 => 4, # unique
  8 => 7, # unique
  2 => 5,
  3 => 5, # and all segments of 1
  5 => 5, # and has 1-4 diff segments
  0 => 6, # does not have 1-4 diff segments
  6 => 6, # and has 1-4 diff segments
  9 => 6, # and all segments of 1, all segments of 7
}

lengths_of_uniques = [2,3,4,7]

# part 1
# appearance_of_uniques = 0
# result.each do |data|
#   data[:output].each { |value| appearance_of_uniques += 1 if lengths_of_uniques.include?(value.size) }
# end
# puts appearance_of_uniques

# Part 2

def has_segments(pattern, value)
  result = true
  pattern.split("").each do |letter|
    result = result && value.match?(letter)
    break if result == false
  end
  result
end

tally = 0

result.each do |data|
  digits = {}

  one = data[:signal].find { |value| value.length == 2}
  digits[one] = 1

  four = data[:signal].find { |value| value.length == 4}
  digits[four] = 4

  seven = data[:signal].find { |value| value.length == 3}
  digits[seven] = 7

  eight = data[:signal].find { |value| value.length == 7}
  digits[eight] = 8

  four_but_not_one = four.split("").select { |value| !one.split("").include?(value)}.join()
  five = data[:signal].find { |value| value.length == 5 && has_segments(four_but_not_one, value)}
  digits[five] = 5

  three = data[:signal].find { |value| value.length == 5 && has_segments(one, value)}
  digits[three] = 3

  two = data[:signal].find { |value| value.length == 5 && value != five && value != three}
  digits[two] = 2

  nine = data[:signal].find { |value| value.length == 6 && has_segments(four, value)}
  digits[nine] = 9

  six = data[:signal].find { |value| value.length == 6 && has_segments(four_but_not_one,value) && value != nine }
  digits[six] = 6

  zero = data[:signal].find { |value| value.length == 6 && value != nine && value != six }
  digits[zero] = 0

  output_as_digits = []
  data[:output].each { |value| output_as_digits << digits[value].to_s }
  tally += output_as_digits.join().to_i
end
puts tally
