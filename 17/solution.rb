#! /usr/bin/env ruby
# target area: x=20..30, y=-10..-5
# xmin = 20
# xmax = 30
# ymin = -10
# ymax = -5
# zone = { xmin: xmin, xmax: xmax, ymin: ymin, ymax: ymax }

# target area: x=282..314, y=-80..-45
xmin = 282
xmax = 314
ymin = -80
ymax = -45
zone = { xmin: xmin, xmax: xmax, ymin: ymin, ymax: ymax }

def step(x, y, vx, vy)
  x += vx
  y += vy
  if vx > 0
    vx -= 1
  elsif vx < 0
    vx += 1
  end
  vy -= 1
  return x, y, vx, vy
end

def in_strike_zone?(x,y,zone)
  (x >= zone[:xmin] && x <= zone[:xmax]) && (y >= zone[:ymin] && y <= zone[:ymax])
end

def past_strike_zone?(x,y,zone)
  x > zone[:xmax] || y < zone[:ymin]
end

def fire(vx_init, vy_init, zone)
  vx = vx_init
  vy = vy_init
  max_y = 0
  x = 0
  y = 0
  is_a_hit = false
  while !past_strike_zone?(x,y,zone) && !is_a_hit
    x, y, vx, vy = step(x,y,vx,vy)
    max_y = y if y > max_y
    is_a_hit = in_strike_zone?(x,y,zone)
  end
  return vx_init, vy_init, is_a_hit, max_y
end

hits = []
best = nil
all_time_max_y = 0
(1..1000).each do |vx|
  puts vx
  (0..2000).each do |vy_offset|
    vy = -1000 + vy_offset
    vx_init, vy_init, is_a_hit, max_y = fire(vx,vy,zone)
    hits << [vx_init, vy_init] if is_a_hit
    if is_a_hit && max_y > all_time_max_y
      all_time_max_y = max_y
      best = [vx_init, vy_init]
    end
  end
end
pp best
puts all_time_max_y
puts hits.size


