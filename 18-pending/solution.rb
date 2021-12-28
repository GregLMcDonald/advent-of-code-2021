#! /usr/bin/env ruby
is_test = true
filename = is_test ? "test.txt" : "data.txt"

def parse(line)
  guts = line.match(/^\[(.*)\]$/)[1]
  result = []
  while guts != ""
    if guts.match?(/^\d+/)
      match = guts.match(/^(\d+)/)
      result << match[1].to_i
      guts = guts[match[0].length, guts.length]
    elsif guts[0] == ","
      guts = guts[1,guts.length]
      guts
    else # must be [
      i = 0
      left_bracket = 0
      closing_bracket_index = nil
      while closing_bracket_index == nil && i < guts.length
        case guts[i]
        when "["
          left_bracket += 1
        when "]"
          left_bracket -= 1
          closing_bracket_index = i if left_bracket == 0
        end
        i += 1
      end
      sub_guts = guts[0, closing_bracket_index + 1]
      guts = guts[closing_bracket_index + 1, guts.length]
      result << parse(sub_guts)
    end
  end
  result
end

#test parser
puts "[[1,2],3] parsed? #{parse("[[1,2],3]") == [[1,2],3]}"
puts "[[[[1,2],[3,4]],[[5,6],[7,8]]],9] parsed? #{parse("[[[[1,2],[3,4]],[[5,6],[7,8]]],9]") == [[[[1,2],[3,4]],[[5,6],[7,8]]],9]}"
puts ">>>>>>\n\n"

def regular_pair?(pair)
  pair[0].is_a?(Integer) && pair[1].is_a?(Integer)
end
def explode?(pair, level)
  regular_pair?(pair) && level == 4
end

def do_explosion(numb, level = 0)

end
puts "test [[[[[9,8],1],2],3],4] exposion: #{ do_explosion([[[[[9,8],1],2],3],4]) == [[[[0,9],2],3],4] }"
puts "test [7,[6,[5,[4,[3,2]]]]] explosion: #{ do_explosion([7,[6,[5,[4,[3,2]]]]]) == [7,[6,[5,[7,0]]]]}"
def do_split(numb)
end

def reduce(numb)
  pp numb
  result = do_explosion(numb)
  result = do_split(numb) if result == numb
  result = reduce(result) if result != numb
  result
end

def add(a,b)
  return a == nil ? b : [a,b]
end

# sum = nil
# File.open(filename).readlines(chomp: true).each do |line|
#   sum = add(sum, parse(line))
#   sum = reduce(sum)
# end
# pp sum





