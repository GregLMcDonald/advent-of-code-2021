#! /usr/bin/env ruby

require "./read_input"
require "./board"
result = read_input("data.txt")
winning_board_indices = []
winning_value = nil
winning_value_for_board = Array.new(result[:boards].size, nil)
index_of_last_winning = nil
result[:values].each do |value|
  result[:boards].each_with_index do |board, index|
    if winning_board_indices.none? { |item| item == index }
      update_board(board, value)
      if winning_board?(board)
        winning_board_indices << index
        winning_value = value
      end
    end
  end
end
winning_board = result[:boards][winning_board_indices.last]
puts compute_score(winning_board, winning_value)
