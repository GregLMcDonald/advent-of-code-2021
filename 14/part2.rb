#! /usr/bin/env ruby
is_test = false
filename = is_test ? "test.txt" : "data.txt"
rules = {}
File.open(filename).readlines(chomp: true).map { |line| line.match(/(?<pair>[A-Z][A-Z]) -> (?<insert>[A-Z])/) }.each { |match_data| rules[match_data[:pair]] = match_data[:insert] }
start = is_test ? "NNCB" : "BCHCKFFHSKPBSNVVKVSK"

frequency_table = {}

possible_letters = start.chars + rules.values
possible_letters.uniq!.sort
possible_letters.each { |letter| frequency_table[letter] = 0 }

pp frequency_table.keys
puts frequency_table.keys.size

puts rules.keys.size


def do_insertion(polymer, rules, frequency_table)
  head = polymer[0]
  frequency_table[head] += 1

  tail = polymer[1, polymer.length]
  pair = [head, tail[0]].join
  insert = rules[pair]
  # result = []
  # polymer = polymer.chars
  # while polymer.length > 1
  #   first = polymer.shift
  #   first_pair = [first, polymer.first].join
  #   insertion = rules[first_pair]
  #   if insertion != nil
  #     result << first
  #     result << insertion
  #   else
  #     result << first
  #   end
  # end
  # result << polymer
  # result.join
  frequency_table
end
frequency_table = do_insertion(start, rules, frequency_table)


nb_iterations = 40

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

puts "#{least_common_letter}: #{least_common_count}"
puts "#{most_common_letter}: #{most_common_count}"
puts most_common_count - least_common_count


