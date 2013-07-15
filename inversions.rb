# http://stackoverflow.com/questions/337664/counting-inversions-in-an-array
def merge(a, left, right)
  i, j, count = 0, 0, 0
  while (i < left.size || j < right.size) do
    if i == left.size
      a[i + j] = right[j]
      j += 1
    elsif j == right.size
      a[i + j] = left[i]
      i += 1
    elsif left[i] <= right[j]
      a[i + j] = left[i]
      i += 1
    else
      a[i + j] = right[j]
      count += left.size - i
      j += 1
    end
  end
  count
end

def solution(a)
  return 0 if a.size < 2
  middle = (a.size + 1) / 2
  left = a[0..(middle - 1)]
  right = a[middle..-1]
  solution(left) + solution(right) + merge(a, left, right)
end

puts "result: #{solution([])}"
puts "result: #{solution([1])}"
puts "result: #{solution([1, 5])}"
puts "result: #{solution([4, 1])}"
puts "result: #{solution([4, 1, 2, 3, 9])}"
puts "result: #{solution([4, 1, 3, 2, 9, 5])}"
puts "result: #{solution([4, 1, 3, 2, 9, 1])}"

puts "result: #{solution([6, 9, 1, 14, 8, 12, 3, 2])}"
puts "result: #{solution([1, 2, 3, 4, 5, 6])}"

sample = []
(1..100_000).each { |i| sample << (rand * 100_000).to_int }
puts "result: #{solution(sample)}"
