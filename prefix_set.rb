def solution(a)
  uniq = a.uniq
  a.find_index { |value| value == uniq[-1] }
end

puts "result: #{solution([2])}"
puts "result: #{solution([2, 2, 1, 0, 1, 0])}"

sample = []
(1..100_000).each { |i| sample << (rand * 100_000).to_int }
puts "result: #{solution(sample)}"
