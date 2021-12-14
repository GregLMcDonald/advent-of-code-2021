#! /usr/bin/env ruby

require "./parse_data"
data = parse_data("data.txt")
# data = parse_data("test2.txt")

opens = ["<", "(", "[", "{"]
closes = [">", ")", "]", "}"]
valid_close = {
  "(" => ")",
  "<" => ">",
  "{" => "}",
  "[" => "]",
}

regex_valid = begin
  valid = []
  opens.each { |opener| valid << "\\#{opener}\\#{valid_close[opener]}" }
  Regexp.new(valid.join("|"))
end

invalid = {}
closes.each do |close|
  invalid_for_close = []
  opens.each do |opener|
    next if valid_close[opener] == close
    invalid_for_close << "\\#{opener}\\#{close}"
  end
  invalid[close] = Regexp.new(invalid_for_close.join("|"))
end

corrupted = {}
incompletes = []
data.each_with_index do |line, index|
  yo = line.join()
  while yo.length > 0
    initial = yo
    yo = yo.gsub(regex_valid,"")
    break if initial == yo
  end
  corrupted[index] = nil
  if yo.length > 0
    invalid.each_pair do |key, regex|
      if regex.match(yo)
        corrupted[index] = key
        break
      end
    end
  end
  incompletes << yo if corrupted[index] == nil
end

puts "incompletes #{incompletes.size}"
scores = []
incompletes.each do |incomplete|
  score = 0
  incomplete.split("").reverse.each do |symbol|
    score *= 5
    score += case symbol
             when "(" then 1
             when "[" then 2
             when "{" then 3
             when "<" then 4
             end
  end
  scores << score
end

scores.sort!
middle_index = (scores.size.to_f * 0.5)
middle_index = middle_index.floor
puts scores[middle_index]
