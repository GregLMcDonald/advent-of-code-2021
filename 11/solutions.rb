#! /usr/bin/env ruby

require "./parse_data"
data = parse_data("data.txt")
 # data = parse_data("test.txt")


def init_flashed(data)
  col_count = data[0].size
  row_count = data.size
  Array.new(row_count) { Array.new(col_count, 0) }
end

def compute_step(data)
  flashed = init_flashed(data)
  col_count = data[0].size
  col_min = 1
  col_max = col_count - 2
  row_min = 1
  row_max = data.size - 2
  (row_min..row_max).each do |row_index|
    (col_min..col_max).each do |col_index|
      value = data[row_index][col_index]
      data[row_index][col_index] = value + 1
    end
  end
  while data.flatten.find { |element| element != nil && element > 9} != nil
    (row_min..row_max).each do |row_index|
      (col_min..col_max).each do |col_index|
        value = data[row_index][col_index]
        if value > 9
          data[row_index][col_index] = 0
          flashed[row_index][col_index] = 1
          (-1..1).each do |row_offset|
            (-1..1).each do |col_offset|
              r = row_index + row_offset
              c = col_index + col_offset
              next if (row_offset == 0 && col_offset == 0) || data[r][c] == nil || flashed[r][c] == 1
              value2 = data[r][c]
              data[r][c] = value2 + 1
            end
          end
        end
      end
    end
  end
  {data: data, flashed: flashed}
end

# part 1
# tally = 0
# (1..100).each do |i|
#   result = compute_step(data)
#   data = result[:data]
#   tally += result[:flashed].flatten.inject(0) { |sum,x| sum + x }
# end
# puts tally


# part 2
def all_flashed(result)
  nb_octopi = result[:data].flatten.compact.size
  # nb_flahed = result[:flashed].flatten.inject(0) { |sum,x| sum + x }
  nb_flahed = result[:flashed].flatten.reduce(:+)
  nb_flahed == nb_octopi
end

step = 0
all_flashed_step = false
while !all_flashed_step
  result = compute_step(data)
  data = result[:data]
  all_flashed_step = all_flashed(result)
  step += 1
end
puts step