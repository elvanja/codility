def solutionX(arr)
  a = arr.dup
  count = 1
  dominator = -1
  a.each do |value|
    value_count = a.count(value)
    a.delete(value)
    next unless value_count > count
    count = value_count
    dominator = value
  end
  dominator
end

def solution(a)
  count = 1
  dominator = -1
  candidate_count = 0
  candidate = a.first
  a.sort.each do |value|
    candidate_count += 1 and next if value == candidate
    if candidate_count > count
      dominator = candidate
      count = candidate_count
    end
    candidate = value
    candidate_count = 1
  end
  if candidate_count > count
    dominator = candidate
    count = candidate_count
  end
  dominator
end

puts "result: #{solution([3, 4, 5, 6, 7])}"
puts "result: #{solution([3, 4, 5, 6, 7, 6, 5, 4, 3])}"
puts "result: #{solution([3, 67, 23, 67, 67])}"

sample = []
(1..1_000_000).each { |i| sample << (rand * 1000).to_int }
puts "result: #{solution(sample)}"
