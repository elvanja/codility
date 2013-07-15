# http://stackoverflow.com/questions/12123744/counting-tilings-of-a-rectangle
# http://en.wikipedia.org/wiki/Bin_packing_problem
def solution(n, m)
  # n..1_000_000, m..7
  rect = Array.new(n){Array.new(m){1}}
  rect
end

puts "result: #{solution(4, 3)}"
