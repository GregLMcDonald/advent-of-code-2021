def parse_data(filename)
  dots = []
  folds = []
  max_x = 0
  max_y = 0
  file = File.open(filename)
  file.readlines(chomp: true).each do |line|
    if line.match(/^fold/)
      match_data = line.match(/^fold along (?<axis>[x|y])=(?<value>\d+)$/)
      folds << { axis: match_data[:axis], value: match_data[:value].to_i }
    elsif line != ""
      coords = line.split(",").map(&:to_i)
      max_x = coords[0] if coords[0] > max_x
      max_y = coords[1] if coords[1] > max_y

      dots << { x: coords[0], y: coords[1] }
    end
  end
  file.close()
  { dots: dots, folds: folds, max_x: max_x, max_y: max_y }
end