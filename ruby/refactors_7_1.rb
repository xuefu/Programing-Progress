# Here is a really wonderful and interesting thing you can have a brain storm
# short-circuit evaluation

def a
  puts "A was evaluated!"
  return true
end

def b
  puts "B was also evaluated!"
  return true
end

puts a || b
puts "------"
puts a && b
