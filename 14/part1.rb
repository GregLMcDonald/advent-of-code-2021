#! /usr/bin/env ruby
is_test = true
filename = is_test ? "test.txt" : "data.txt"
rules = {}
File.open(filename).readlines(chomp: true).map { |line| line.match(/(?<pair>[A-Z][A-Z]) -> (?<insert>[A-Z])/) }.each { |match_data| rules[match_data[:pair]] = match_data[:insert] }
start = is_test ? "NNCB" : "BCHCKFFHSKPBSNVVKVSK"

def do_insertion(polymer, rules)
  result = []
  polymer = polymer.chars
  while polymer.length > 1
    first = polymer.shift
    first_pair = [first, polymer.first].join
    insertion = rules[first_pair]
    if insertion != nil
      result << first
      result << insertion
    else
      result << first
    end
  end
  result << polymer
  result.join
end

# part 1
# nb_iterations = 10

# part 2
# nb_iterations = 40 # no joy. this blows up!

polymer = start
(1..nb_iterations).each do |i|
  polymer = do_insertion(polymer, rules)
  puts "#{i} #{polymer.length}"
end

frequency_table = {}
polymer.chars.each do |letter|
  current = frequency_table[letter] || 0
  current += 1
  frequency_table[letter] = current
end
least_common_letter = frequency_table.keys.first
least_common_count = frequency_table[least_common_letter]
most_common_letter = least_common_letter
most_common_count = least_common_count
frequency_table.each_pair do |k,v|
  if v < least_common_count
    least_common_letter = k
    least_common_count = v
  end
  if v > most_common_count
    most_common_letter = k
    most_common_count = v
  end
end
puts least_common_letter
puts least_common_count
puts most_common_letter
puts most_common_count
puts most_common_count - least_common_count


