#! /usr/bin/env ruby
is_test = false
filename = is_test ? "test.txt" : "data.txt"
rules = {}
File.open(filename).readlines(chomp: true).map { |line| line.match(/(?<pair>[A-Z][A-Z]) -> (?<insert>[A-Z])/) }.each { |match_data| rules[match_data[:pair]] = match_data[:insert] }
polymer_template = is_test ? "NNCB" : "BCHCKFFHSKPBSNVVKVSK"

class Dude
  def initialize(max_depth, rules)
    @max_depth = max_depth
    @rules = rules
    @tables = {}
  end

  def combine_tables(a, b)
    result = {}
    keys = (a.keys + b.keys).flatten.uniq
    keys.each do |key|
      a_val = a[key] || 0
      b_val = b[key] || 0
      result[key] = a_val + b_val
    end
    result
  end

  def frequencies(template)
    result = {}
    template.chars.each { |char| result[char] = result[char] == nil ? 1 : result[char] + 1 }
    result
  end

  def build_pairs(template)
    starts = template[0, (template.size - 1)]
    ends = template[1, template.size]
    pairs = starts.chars.zip(ends.chars).map(&:join)
  end

  def wowser(depth, pair)
    dd = @max_depth - depth
    result = {}
    return result if dd == 0
    return @tables[pair][dd] if @tables[pair] && @tables[pair][dd]

    insertion = @rules[pair]
    result[insertion] = 1
    return result if dd == 1

    new_template = [pair[0], insertion, pair[1]].join
    build_pairs(new_template).each do |pair|
      result = combine_tables(result, wowser(depth + 1, pair))
    end
    @tables[pair] ||= {}
    @tables[pair][dd] = result
    result
  end

  def awesomeness(depth, template)
    result = frequencies(template)
    starts = template[0, (template.size - 1)]
    ends = template[1, template.size]
    pairs = starts.chars.zip(ends.chars)
    pairs.each do |pair|
      result = combine_tables(result, wowser(depth, pair.join))
    end
    result
  end
end

dude = Dude.new(40, rules)
frequency_table = dude.awesomeness(0, polymer_template)

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


