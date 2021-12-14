def find_danger_points(crossings, danger_test)
  result = {}
  crossings.keys.each do |y|
    row = crossings[y]
    row.keys.each do |x|
      update_crossing(result, x, y, row[x])  if danger_test.call(row[x])
    end
  end
  result
end