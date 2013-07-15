def solution(a)
  sum = a.inject(&:+)
  left_sum = 0
  a.each_with_index do |value, index|
    right_sum = sum - left_sum - value
    return index if left_sum == right_sum
    left_sum = left_sum + value
  end
  return -1
end

puts "result: #{solution([-7, 1, 5, 2, -4, 3, 0])}"

sample = []
(1..100_000).each { |i| sample << (rand * 100_000).to_int }
puts "result: #{solution(sample)}"
