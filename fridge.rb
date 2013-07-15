class Store
  attr_accessor :index, :closes_in, :successors, :distance

  def initialize(index, closes_in)
    @index, @closes_in = index, closes_in
    @successors = []
  end
end

class Successor
  attr_accessor :store_index, :distance, :store

  def initialize(store_index, distance)
    @store_index, @distance = store_index, distance
  end
end

def map_village(a, b, c, d)
  stores = []
  d.each_with_index do |closes_in, store_index|
    stores << Store.new(store_index, closes_in)
  end

  (0..(a.size - 1)).each do |from_index|
    from = a[from_index]
    to = b[from_index]

    next if from == to
    next unless from >= 0 && from < d.size
    next unless to >= 0 && to < d.size

    distance = c[from_index]
    stores[from].successors << Successor.new(to, distance)
    stores[to].successors << Successor.new(from, distance)
  end

  # convert store indexes to stores in successors
  stores.each do |store|
    #store.successors.uniq! # remove duplicates
    store.successors.each do |successor|
      successor.store = stores[successor.store_index]
    end
  end

  stores
end

# http://en.wikipedia.org/wiki/Dijkstra%27s_algorithm
def travel(stores)
  unvisited = stores.dup
  current = stores[0]
  current.distance = 0

  while unvisited.size > 0
    has_non_visited_neighbours = false

    current.successors.select { |successor| unvisited.include?(successor.store) }.each do |successor|
      has_non_visited_neighbours = true
      distance_over_current_successor = current.distance + successor.distance
      successor.store.distance = distance_over_current_successor and next unless successor.store.distance
      successor.store.distance = [successor.store.distance, distance_over_current_successor].min
    end

    break unless has_non_visited_neighbours

    unvisited.delete(current)
    current = unvisited.select { |store| store.distance != nil }.sort_by { |store| store.distance }.first
  end
end

def solution(a, b, c, d)
  #start = Time.now.nsec
  stores = map_village(a, b, c, d)
  #puts "creates stores: #{spaces_on(Time.now.nsec - start)}"

  #start = Time.now.nsec
  travel(stores)
  #puts "travel: #{spaces_on(Time.now.nsec - start)}"

  #start = Time.now.nsec
  time = stores.select { |store| store.distance && store.distance <= store.closes_in }.map(&:distance).min || -1
  #puts "time: #{spaces_on(Time.now.nsec - start)}"
  time
end

def spaces_on(number)
  number.to_s.gsub(/\D/, '').reverse.gsub(/.{3}/, '\0.').reverse
end

a, b, c, d = [], [], [], []
10_000.times do
  a << (rand * 99).to_int
  b << (rand * 99).to_int
  c << (rand * 100_000).to_int
end
#100.times { |i| d << (rand * 1_000_000_000).to_int }
#100.times { |i| d << (i % 10 == 0 ? -1 : (rand * 1_000_000_000).to_int) }
100.times { |i| d << (i % 10 == 0 ? -1 : (rand * 1_000).to_int) }
#100.times { |i| d << -1 }
d[0] = -1
#d[87] = (rand * 1_000).to_int
puts "big random result: #{solution(a, b, c, d)}"
#exit

result = solution(
  [9,   4, 3,  1, 7, 0, 5, 10,  8, 6, 2, 10, 2, 5, 1, 10, 2, 6,  1, 6, 3, 3, 0,  8, 6, 9,  4, 6, 2, 4,  9, 11, 14, 15, 18, 19, 14, 15, 16,  4,  3,  1,  7,  0,  5, 10, 8,  6,  2, 10],
  [5,   1, 8,  9, 6, 4, 8,  8, 10, 6, 3, 10, 4, 6, 7,  7, 6, 3,  1, 4, 4, 8, 7,  7, 1, 1,  4, 6, 4, 8, 11, 12, 13, 16, 17, 20,  8,  9, 10, 11, 12, 13, 16, 17, 20,  8, 9, 10,  1,  3],
  [10, 11, 5, 11, 3, 9, 9,  2,  2, 5, 7, 15, 7, 1, 5, 12, 5, 9, 11, 2, 3, 8, 6, 10, 7, 9, 12, 7, 4, 4,  7,  5, 11,  1, 10,  2,  2, 14,  7,  9, 11,  2,  3,  8,  6, 10, 7,  9, 12,  7],
  [-1, 977, 999999999, 17, 8, 683, 8, 5, 12, 808, 191, 1050, 157, 999555, 5684, 5697, 49, 557, 23, 56, 233]
)
puts "result: #{result}, expected: 8"
#exit

result = solution(
  [9,   4, 3,  1, 7, 0, 5, 10,  8, 6, 2, 10, 2, 5, 1, 10, 2, 6,  1, 6, 3, 3, 0,  8, 6, 9,  4, 6, 2, 4],
  [5,   1, 8,  9, 6, 4, 8,  8, 10, 6, 3, 10, 4, 6, 7,  7, 6, 3,  1, 4, 4, 8, 7,  7, 1, 1,  4, 6, 4, 8],
  [10, 11, 5, 11, 3, 9, 1,  2,  2, 5, 7,  5, 7, 1, 5, 12, 5, 9, 11, 2, 3, 8, 6, 10, 7, 9, 12, 7, 4, 4],
  [-1, 977, 999999999, 17, 8, 683, 8, 5, 12, 808, 191]
)
puts "result: #{result}, expected: 10"

result = solution(
  [3, 1, 3, 1, 1],
  [1, 1, 2, 1, 1],
  [4, 10, 1, 9, 2],
  [-1, 999999999, 1000000000, 1000000000]
)
puts "result: #{result}, expected: -1"

result = solution(
  [9, 0, 2, 5, 6, 11, 8, 7, 0, 10, 9, 9, 4, 7],
  [5, 9, 7, 9, 2, 8, 1, 8, 7, 7, 11, 7, 4, 11],
  [9, 12, 3, 7, 8, 8, 7, 9, 10, 12, 10, 11, 5, 8],
  [-1, 25, 999999999, 999999999, 999999999, 427, 1000000000, 132, 18, 11, 1000000000, 17]
)
puts "result: #{result}, expected: 10"

result = solution(
  [3, 1, 0, 5, 2, 5, 3, 0, 5, 5, 3, 5, 1, 5, 5],
  [2, 3, 5, 0, 5, 3, 3, 0, 1, 5, 5, 5, 1, 5, 4],
  [3, 1, 8, 5, 12, 1, 1, 12, 3, 8, 8, 1, 10, 10, 1],
  [-1, 10, 11, 8, 350, 390]
)
puts "result: #{result}, expected: 5"

result = solution(
  [6, 6, 3, 8, 8, 6, 7, 5, 1, 4, 3, 2, 7, 7],
  [3, 7, 5, 8, 0, 6, 3, 4, 1, 7, 1, 5, 3, 2],
  [8, 1, 9, 12, 11, 1, 8, 12, 3, 6, 12, 7, 4, 2],
  [-1, 1000000000, 1000000000, 999999999, 999999999, 999999999, 1000000000, 1000000000, 1000000000]
)
puts "result: #{result}, expected: 11"

result = solution(
  [0, 0, 3],
  [1, 2, 1],
  [2, 1, 1],
  [-1, 2, 3, 1]
)
puts "result: #{result}, expected: 1"

result = solution(
  [0, 1, 3, 1, 2, 2], # from
  [1, 2, 2, 3, 0, 1], # to
  [2, 3, 4, 5, 7, 5], # distance between from and to
  [-1, 1, 3, 8]       # seconds before closing
)
puts "result: #{result}, expected: 7"

result = solution(
  [0, 1, 2, 1],
  [1, 2, 3, 3],
  [2, 3, 4, 5],
  [-1, 1, -1, 8]
)
puts "result: #{result}"
