#! /usr/bin/env ruby

require "./read_data"
require "./build_crossings"
require "./find_danger_points"

def count_elements(point_set)
  tally = 0
  point_set.keys.each do |y|
    row = point_set[y]
    row.keys.each { |x| tally += 1 }
  end
  tally
end

lines = read_data("data.txt")
crossings = build_crossings(lines, true)
danger_points = find_danger_points(crossings, ->(value) { value >= 2 })
nb_points = count_elements(danger_points)
pp nb_points