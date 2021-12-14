#! /usr/bin/env ruby

fish = [2,1,1,1,1,1,1,5,1,1,1,1,5,1,1,3,5,1,1,3,1,1,3,1,4,4,4,5,1,1,1,3,1,3,1,1,2,2,1,1,1,5,1,1,1,5,2,5,1,1,2,1,3,3,5,1,1,4,1,1,3,1,1,1,1,1,1,1,1,1,1,1,1,4,1,5,1,2,1,1,1,1,5,1,1,1,1,1,5,1,1,1,4,5,1,1,3,4,1,1,1,3,5,1,1,1,2,1,1,4,1,4,1,2,1,1,2,1,5,1,1,1,5,1,2,2,1,1,1,5,1,2,3,1,1,1,5,3,2,1,1,3,1,1,3,1,3,1,1,1,5,1,1,1,1,1,1,1,3,1,1,1,1,3,1,1,4,1,1,3,2,1,2,1,1,2,2,1,2,1,1,1,4,1,2,4,1,1,4,4,1,1,1,1,1,4,1,1,1,2,1,1,2,1,5,1,1,1,1,1,5,1,3,1,1,2,3,4,4,1,1,1,3,2,4,4,1,1,3,5,1,1,1,1,4,1,1,1,1,1,5,3,1,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,5,1,1,1,1,1,1,1,1,5,1,4,4,1,1,1,1,1,1,1,1,3,1,3,1,4,1,1,2,2,2,1,1,2,1,1]
fish_by_time_to_reproduce = {}
fish.each do |value|
  current = fish_by_time_to_reproduce[value] || 0
  current += 1
  fish_by_time_to_reproduce[value] = current
end
pp fish_by_time_to_reproduce

max_days = 256
day = 1
while day <= max_days
  puts day
  updated_fish = {}
  fish_ready_to_reproduce = fish_by_time_to_reproduce[0] || 0
  fish_by_time_to_reproduce.each_pair do |key, value|
    next if key == 0
    updated_fish[key-1] = value
  end
  updated_fish[8] = fish_ready_to_reproduce

  updated_fish[6] ||= 0
  updated_fish[6] += fish_ready_to_reproduce

  fish_by_time_to_reproduce = updated_fish
  day += 1
end
tally = 0
pp fish_by_time_to_reproduce
fish_by_time_to_reproduce.values.each { |value| tally += value }
puts tally