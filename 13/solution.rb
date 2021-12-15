#! /usr/bin/env ruby

require "./parse_data"
# data = parse_data("test.txt")
data = parse_data("data.txt")
# puts data[:max_x]
# puts data[:max_y]
# puts data[:folds].first

grid = Array.new(data[:max_y] + 1) { Array.new(data[:max_x] + 1, false)}
data[:dots].each { |dot| grid[dot[:y]][dot[:x]] = true}
first_fold = data[:folds].first

def do_fold(fold, grid, data)
  new_grid = []
  if fold[:axis] == "y"
    value = fold[:value]
    immediately_above_fold_y = value - 1
    immediately_below_fold_y = value + 1
    max_y = grid.size - 1
    delta_y = max_y - immediately_below_fold_y
    (0..delta_y).each do |offset|
      below_fold_y = immediately_below_fold_y + offset
      above_fold_y = immediately_above_fold_y - offset
      result = []
      grid[above_fold_y].each_with_index { |elem, index| result << (elem || grid[below_fold_y][index]) }
      grid[above_fold_y] = result
    end
    (0..delta_y).each { |i| grid.pop }
    new_grid = grid
  else
    value = fold[:value]
    immediately_right_of_fold_x = value + 1
    immediately_left_of_fold_x = value - 1
    max_x = grid[0].size - 1
    delta_x = max_x - immediately_right_of_fold_x
    grid.each do |row|
      new_row = []
      (0..immediately_left_of_fold_x).each { |i| new_row << row[i] }
      (0..delta_x).each do |offset|
        x = immediately_left_of_fold_x - offset
        new_row[x] = new_row[x] || row[immediately_right_of_fold_x + offset]
      end
      new_grid << new_row
    end
  end
  new_grid
end

# part 1
# grid = do_fold(data[:folds].first, grid, data)
# puts grid.flatten.select { |elem| elem == true }.size


# part 2
data[:folds].each do |fold|
  grid = do_fold(fold, grid, data)
end
as_dots = []
grid.each { |row| as_dots << row.map { |elem| elem ? "#" : "." }}
pp as_dots.map { |row| row.join() }
