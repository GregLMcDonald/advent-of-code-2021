#! /usr/bin/env ruby
algo = "##..#######.#.#...##..#.#....#..#####..###...#..#.#..##....#.###..#.###..#.#.#.##.######.#.##.#.#..#######.####..#.#.#.##..##.#.#######...#..#...........###.#.........#..#....#.#..##.##....#.##.#...#.##..##....##..#####......#.#.##....#...#########...#..##...####.#####.##.#.###..##.##..#.#..#.......#..##....#.##.######.#.##..##......####...#.##..#...#.###.##..##...#..#####..#.#.###.#.##..##..#####...#.#.#...###..#.##.####.#.#..#####..##.##...#.#.#....####.##..#.##.###.....##.#....#####....###...##.#.#......"
algo = algo.gsub(/#/,"1").gsub(/\./, "0").chars

filename = "input.txt"
image = []
File.open(filename).readlines(chomp: true).each do |line|
  image << line.gsub(/#/,"1").gsub(/\./, "0").chars
end

def pad(a, padding)
  result = []
  result << Array.new(a[0].size + 2, padding)
  a.each { |line| result << [padding, line, padding].flatten }
  result << Array.new(a[0].size + 2, padding)
end

def unpad(a)
  a.shift
  a.pop
  result = []
  a.each { |line| line.shift; line.pop; result << line }
  result
end

def blank(a)
  result = []
  a.each { |line| result << Array.new(line.size, "0") }
  result
end

def process(a, algo)
  result = blank(a)
  start_x = 1
  max_x = a[0].size - 2

  start_y = 1
  max_y = a.size - 2

  (start_y..max_y).each do |y|
    (start_x..max_x).each do |x|
      raw = [a[y-1][x-1, 3], a[y][x-1, 3], a[y+1][x-1, 3]]
      raw = raw.flatten.join("")
      index = raw.to_i(2)
      result[y][x] = algo[index]
    end
  end
  result
end

nb_iterations = 50
# nb_iterations = 2
(1..nb_iterations).each do |i|
  padding = i % 2 == 1 ? "0" : "1"
  padded_image = pad(pad(image, padding), padding)
  processed_image = process(padded_image, algo)
  image = unpad(processed_image)
end
#image.each { |line| puts line.join("").gsub(/0/, ".").gsub(/1/,"#")}
puts image.flatten.select { |elem| elem == "1" }.size
