def solutionNto2(a)
  discs = []
  a.each_with_index do |radius, index|
    discs << [index - radius, index + radius, radius] # from, to, radius
  end
  discs.sort! { |x, y| x[0] <=> y[0] }

  intersections = 0
  upper = discs.size - 1
  discs.each_with_index do |disc, index|
    to = disc[1]
    ((index + 1)..upper).each do |other_index|
      break if discs[other_index][0] > to # from > to
      intersections = intersections + 1
    end
    return -1 if intersections >= 10_000_000
  end
  intersections
end

# http://stackoverflow.com/questions/14042447/counting-disk-intersections-using-treeset
# http://stackoverflow.com/questions/4801242/algorithm-to-calculate-number-of-intersecting-discs
def solution(a)
  start = Hash.new{0}
  stop = Hash.new{0}
  a.each_with_index do |radius, index|
    if index < radius
      start[0] += 1
    else
      start[index - radius] += 1
    end

    if index + radius >= a.size
      stop[a.size - 1] += 1
    else
      stop[index + radius] += 1
    end
  end

  active = 0
  intersections = 0
  (0..(a.size - 1)).each do |i|
    intersections += active * start[i] + (start[i] * (start[i] - 1)) / 2
    return -1 if intersections > 10_000_000
    active += start[i] - stop[i]
  end
  intersections
end

puts "result: #{solution([1, 5, 2, 1, 4, 0])}"
puts "result: #{solution([0, 0, 0, 0, 0, 0])}"
puts "result: #{solution(Array.new(500000){0} + [1])}"

sample = []
(1..1_000_000).each { |i| sample << (rand * 10).to_int }
puts "result: #{solution(sample)}"

