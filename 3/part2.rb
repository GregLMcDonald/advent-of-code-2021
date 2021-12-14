#! /usr/bin/env ruby

def most_common(data, index_of_interest)
  nb_ones = 0
  data.each { |elem| nb_ones += elem[index_of_interest] }
  nb_zeroes = data.size - nb_ones
  if nb_ones == 0
    return 0
  elsif nb_zeroes == 0
    return 1
  else
    if nb_ones > nb_zeroes
      return 1
    elsif nb_ones < nb_zeroes
      return 0
    else
      1
    end
  end
end

def least_common(data, index_of_interest)
  nb_ones = 0
  data.each { |elem| nb_ones += elem[index_of_interest] }
  nb_zeroes = data.size - nb_ones
  if nb_ones == 0
    return 0
  elsif nb_zeroes == 0
    return 1
  else
    if nb_ones > nb_zeroes
      return 0
    elsif nb_ones < nb_zeroes
      return 1
    else
      0
    end
  end
end
class Solver
  def initialize
  end

  def solve(data, index_of_interest, comparator)
    if index_of_interest == data[0].size
      return data[0]
    end
    filter_value = method(comparator).call(data, index_of_interest)
    filtered_data = data.select { |elem| elem[index_of_interest] == filter_value }
    if filtered_data.size == 1
      filtered_data[0]
    else
      solve(filtered_data, index_of_interest + 1, comparator)
    end
  end


end

data = []
$stdin.each_line do |line|
  data << line.chomp.split("").map(&:to_i)
end
oxygen = Solver.new().solve(data, 0, :most_common).map(&:to_s).join().to_i(2)
co2 = Solver.new().solve(data, 0, :least_common).map(&:to_s).join().to_i(2)
puts oxygen
puts co2
puts oxygen * co2
