#! /usr/bin/env ruby

require "./read_input"
require "./board"
result = read_input("data.txt")
winning_board = nil
winning_value = nil
result[:values].each do |value|
  result[:boards].each do |board|
    update_board(board, value)
    if winning_board?(board)
      winning_board = board
      winning_value = value
      break
    end
  end
  break unless winning_board.nil?
end
puts compute_score(winning_board, winning_value)
