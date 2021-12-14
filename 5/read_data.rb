class Point
  def initialize(x,y)
    @x = x
    @y = y
  end

  def x
    @x
  end

  def y
    @y
  end
end

class Line
  def initialize(p1, p2)
    @p1 = p1
    @p2 = p2
  end

  def p1
    @p1
  end

  def p2
    @p2
  end
end

def read_data(filename)
  result = []
  file = File.open(filename)
  current_board = []
  file.readlines(chomp: true).each_with_index do |line, index|
    match = /^(?<pair1>[\d,]+) -> (?<pair2>[\d,]+)$/.match(line)
    p1_values = match[:pair1].split(",").map(&:to_i)
    p1 = Point.new(p1_values[0], p1_values[1])
    p2_values = match[:pair2].split(",").map(&:to_i)
    p2 = Point.new(p2_values[0], p2_values[1])
    result << Line.new(p1,p2)
  end
  result
end