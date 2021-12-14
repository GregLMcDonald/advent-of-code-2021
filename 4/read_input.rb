def read_input(filename)
  result = { boards: [] }
  file = File.open(filename)
  current_board = []
  data = file.readlines(chomp: true).each_with_index do |line, index|
    if index == 0
      result[:values] = line.split(",").map(&:to_i)
    elsif
      if line != ""
        values = line.gsub(/\ +/, ",").split(",").select { |elem| elem != "" }.map(&:to_i)
        row = { values: values, called: [false, false, false, false, false] }
        current_board << row
        if current_board.size == 5
          result[:boards] << current_board
          current_board = []
        end
      end
    end
  end
  result
end