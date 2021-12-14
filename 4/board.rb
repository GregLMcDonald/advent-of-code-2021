def update_board(board, value)
  (0..4).each do |i|
    row = board[i]
    (0..4).each do |j|
      row[:called][j] = true if row[:values][j] == value
    end
  end
end

def winning_board?(board)
  has_winning_row?(board) || has_winning_column?(board)
end

def has_winning_row?(board)
  result = false
  (0..4).each do |i|
    result = board[i][:called].select { |elem| elem == false }.empty?
    break if result == true
  end
  result
end

def has_winning_column?(board)
  column_result = [true, true, true, true, true]
  (0..4).each do |i|
    row_state = board[i][:called]
    (0..4).each do |j|
      column_result[j] = column_result[j] && row_state[j]
    end
  end
  column_result.select { |elem| elem == true }.size > 0
end

def compute_score(board, winning_value)
  sum = 0
  board.each do |row|
    (0..4).each do |i|
      sum += row[:values][i] if row[:called][i] == false
    end
  end
  sum * winning_value
end