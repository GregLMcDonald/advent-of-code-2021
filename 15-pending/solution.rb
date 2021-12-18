#! /usr/bin/env ruby
is_test = true
# filename = is_test ? "test.txt" : "data.txt"
filename = "tiny_test.txt"
data = []
all_dir = ["u", "d", "l", "r"]
File.open(filename).readlines(chomp: true).map { |line| data << line.chars.map(&:to_i).map { |v| { v: v, dir: all_dir.clone}} }

h_moves = data[0].size - 1
v_moves = data.size - 1
moves = Array.new(h_moves, "r") + Array.new(v_moves, "d")
lowest_energy_possible = (h_moves + v_moves) * 1
lowest_energy_found = (h_moves + v_moves) * 9
path = nil

def move(x, y, moves, path)
  move_dir = moves.delete_at(rand(moves.size))
  case move_dir
  when "r" then x = x + 1
  when "d" then y = y + 1
  end
  { moves: moves, x: x, y: y, path: path + move_dir}
end

def move_it(moves, x, y, path)
  while moves.size > 0
    result = move(x, y, moves, path)
    energy += data[y][x][:v]
    moves = result[:moves]
    x = result[:x]
    y = result[:y]
    path = result[:path]
    break if energy >= lowest_energy_found
  end

  if moves.size == 0 && energy < lowest_energy_found
    lowest_energy_found = energy
    path_lowest_energy_found = path
  else
    move_it(moves, x, y, path)
  end
end
move_it(moves, 0, 0, "")
puts lowest_energy_found
puts path_lowest_energy_found