#! /usr/bin/env ruby

require "./parse_data"
data = parse_data("data.txt")
# data = parse_data("test.txt")

col_count = data[0].size
col_min = 1
col_max = col_count - 2
row_min = 1
row_max = data.size - 2

low_points = []
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
    low_points << {row: row_index, col: col_index, value: value} if neighbours.find { |neighbour| neighbour <= value } == nil
  end
end

def tag_and_find_basin_neighbours(data, row_index, col_index, tag)
  data[row_index][col_index] = tag
  [-1, 1].each do |row_offset|
    row = row_index + row_offset
    col = col_index
    value = data[row][col]
    if value != nil && value < 100 && value != 9
      data = tag_and_find_basin_neighbours(data, row, col, tag)
    end
  end
  [-1, 1].each do |col_offset|
    row = row_index
    col = col_index + col_offset
    value = data[row][col]
    if value != nil && value < 100 && value != 9
      data = tag_and_find_basin_neighbours(data, row, col, tag)
    end
  end
  data
end

basin_indices = []
low_points.each_with_index do |p, index|
  basin_index = 100 + index
  basin_indices << basin_index
  data = tag_and_find_basin_neighbours(data, p[:row], p[:col], basin_index)
end
data.flatten!
data.compact!
basin_sizes = []
basin_indices.each do |index|
  basin_sizes << data.select { |value| value == index }.size
end
a = basin_sizes.sort.reverse.first(3)
puts a[0] * a[1] * a[2]


