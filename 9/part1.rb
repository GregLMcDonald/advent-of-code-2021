#! /usr/bin/env ruby

require "./parse_data"
data = parse_data("data.txt")
# data = parse_data("test.txt")

col_count = data[0].size
col_min = 1
col_max = col_count - 2
row_min = 1
row_max = data.size - 2

local_minima = []
(row_min..row_max).each do |row_index|
  (col_min..col_max).each do |col_index|
    value = data[row_index][col_index]
    neighbours = []
    (-1..1).each do |row_offset|
      (-1..1).each do |col_offset|
        neighbours << data[row_index + row_offset][col_index + col_offset] unless ( row_offset == 0 && col_offset == 0)
      end
    end
    neighbours.compact!
    local_minima << value if neighbours.find { |neighbour| neighbour <= value } == nil
  end
end
risk = local_minima.map { |value| value + 1 }
total_risk = risk.sum
puts total_risk



