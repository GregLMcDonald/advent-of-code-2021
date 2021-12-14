#! /usr/bin/env ruby

require "./parse_data"
# data = parse_data("test.txt")
data = parse_data("data.txt")

net = {}
data.each do |item|
  curr = net[item[:a]] || []
  net[item[:a]] = curr << item[:b]

  curr = net[item[:b]] || []
  net[item[:b]] = curr << item[:a]
end

paths = []

def large?(cave)
  cave.downcase != cave
end

def unvisited?(cave, path)
  !path.include?(cave)
end

def terminal?(path)
  path.last == "end"
end

# part 1
# def allowed_to_visit?(cave, path)
#   return false if cave == "start"

#   large?(cave) || unvisited?(cave, path) || cave == "end"
# end

# part 2
def allowed_to_visit?(cave, path)
  return false if cave == "start"
  return true if (large?(cave) || unvisited?(cave, path) || cave == "end")

  small_caves = path.select { |cave| !large?(cave) }
  unique_small_caves = small_caves.uniq
  small_caves.size == unique_small_caves.size
end



def crawl(paths, net)
  new_paths = []
  paths.each do |path|
    if path.last == "end"
      new_paths << path
      next
    end
    caves = net[path.last] || []
    caves.each do |cave|
      new_path = path.clone
      if allowed_to_visit?(cave, path)
        new_path << cave
      else
        new_path = nil
      end
      new_paths << new_path
    end
  end
  new_paths.compact
end

paths = [["start"]]
terminal_paths = []
while paths.size > 0
  result = crawl(paths, net)
  paths = []
  result.each do |path|
    if terminal?(path)
      terminal_paths << path
    else
      paths << path
    end
  end
end

puts terminal_paths.size


