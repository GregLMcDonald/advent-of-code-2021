#! /usr/bin/env ruby
is_test = true
filename = is_test ? "test.txt" : "data.txt"
rules = {}
File.open(filename).readlines(chomp: true).map { |line| line.match(/(?<pair>[A-Z][A-Z]) -> (?<insert>[A-Z])/) }.each { |match_data| rules[match_data[:pair]] = match_data[:insert] }
# polymer_template = is_test ? "NNCB" : "BCHCKFFHSKPBSNVVKVSK"
polymer_template = "NN"

frequency_table = {}

possible_letters = polymer_template.chars + rules.values
possible_letters.uniq!.sort
possible_letters.each { |letter| frequency_table[letter] = 0 }
polymer_template.chars.each { |char| frequency_table[char] += 1}

def insert(template, depth, max_depth, frequency_table, rules)
  # puts "template: #{template}"
  starts = template[0, (template.size - 1)]
  ends = template[1, template.size]
  pairs = starts.chars.zip(ends.chars)
  pairs.each_with_index do |pair, index|
    pattern = pair.join
    insertion = rules[pattern]
    frequency_table[insertion] += 1
    local_depth = depth + 1
    new_template = [pair[0], insertion, pair[1]].join
    # puts new_template
    if depth < max_depth
      frequency_table = insert(new_template, local_depth, max_depth, frequency_table, rules)
    end
  end
  frequency_table
end

frequency_table = insert(polymer_template, 0, 20, frequency_table,  rules)
pp frequency_table
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


