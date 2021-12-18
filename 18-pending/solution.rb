#! /usr/bin/env ruby
is_test = true
filename = is_test ? "test.txt" : "data.txt"


def reduce(line)
  line
end

def simple_pair?(s)
  s.match?(/^\[\d+,\d+\]$/)
end

def parse(line)
  tree = nil
  while line != ""
    if line.match?(/^\[/)
      line = line[1,line.length]
    elsif line.match?(/^\d+,\d+\]/)
      match_data = line.match(/^(?<left>\d+),(?<right>\d+)\]/)
      pp match_data
      puts match_data[0].length
      line = line[match_data[0].length, line.length]
    else
      line = parse(line)
    end
  end
  tree
end

def add(a,b)
  return a == nil ? b : "[#{a},#{b}]"
end

sum = nil
File.open(filename).readlines(chomp: true).each do |line|
  sum = add(sum, line)
  sum = reduce(sum)
  parse(sum)
  #puts sum
end

