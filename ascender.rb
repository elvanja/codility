def solutionX(a)
  closest = []
  upper = a.size - 1
  a.each_with_index do |value, index|
    left = nil
    (0..(index - 1)).each do |other_index|
      actual_index = index - other_index - 1
      left = actual_index and break if a[actual_index] > value
    end if index > 0
    right = nil
    ((index + 1)..upper).each do |other_index|
      right = other_index - index and break if a[other_index] > value
    end if index < upper
    closest << ([left ? index - left : nil, right].compact.min || 0)
  end
  closest
end

def solution(a)
  closest = []
  a.each_with_index do |value, index|
    left = a[0..(index - 1)].index { |other| other > value } if index > 0
    right = a[(index + 1)..-1].index { |other| other > value }
    closest << ([left ? index - left : nil, right ? right + 1 : nil].compact.min || 0)
  end
  closest
end

puts "result: #{solution([4, 3, 1, 4, -1, 2, 1, 5, 7])}"

sample = []
(1..100_000).each { |i| sample << (rand * 1000).to_int }
puts "result size: #{solution(sample).size}"
