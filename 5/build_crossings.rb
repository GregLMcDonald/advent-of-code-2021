def horizontal?(line)
  line.p1.y == line.p2.y
end

def vertical?(line)
  line.p1.x == line.p2.x
end

def update_crossing(crossings, x, y, delta)
  row = crossings[y] || {}
  col = row[x] || 0
  col += delta
  row[x] = col
  crossings[y] = row
  crossings
end

def build_crossings(lines, include_diagonals = false)
  crossings = {}
  lines.each do |line|
    if horizontal?(line)
      y = line.p1.y
      x1 = line.p1.x
      x2 = line.p2.x
      x_range = (x1..x2).to_a
      x_range = (x2..x1).to_a if x_range.empty?
      x_range.each { |x| update_crossing(crossings, x, y, 1) }
    elsif vertical?(line)
      x = line.p1.x
      y1 = line.p1.y
      y2 = line.p2.y
      y_range = (y1..y2).to_a
      y_range = (y2..y1).to_a if y_range.empty?
      y_range.each { |y| update_crossing(crossings, x, y, 1) }
    elsif include_diagonals
      x_delta = line.p2.x - line.p1.x
      x_steps = x_delta.abs
      x_delta /= x_steps
      y_delta = line.p2.y - line.p1.y
      y_delta = y_delta / y_delta.abs
      i = 0
      while i <= x_steps
        x = line.p1.x + i * x_delta
        y = line.p1.y + i * y_delta
        update_crossing(crossings, x, y, 1)
        i += 1
      end
    end
  end
  crossings
end