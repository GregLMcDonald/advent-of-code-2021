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
data.each_with_index do |line, index|
  yo = line.join()
  while yo.length > 0
    initial = yo
    yo = yo.gsub(regex_valid,"")
    break if initial == yo
  end
  if yo.length > 0
    invalid.each_pair do |key, regex|
      if regex.match(yo)
        corrupted[index] = key
        break
      end
    end
  else
    corrupted[index] = nil
  end
end

tally = 0
corrupted.values.compact.each do |value|
  points = case value
            when ")" then 3
            when "]" then 57
            when "}" then 1197
            when ">" then 25137
            end
  tally += points
end
pp tally

