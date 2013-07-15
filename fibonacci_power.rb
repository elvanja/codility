def fibonacci(x)
  fib_1 = 1
  fib_2 = 0
  fib = 0
  (2..x).each do |y|
    fib = fib_1 + fib_2
    fib_2 = fib_1
    fib_1 = fib
  end
  fib
end

# http://stackoverflow.com/questions/9439352/codility-fibonacci-solution
# http://www.maths.surrey.ac.uk/hosted-sites/R.Knott/Fibonacci/fibmaths.html
def solution(n, m)
  f = fibonacci(n**m)
  f % 10_000_103
end

puts "result: #{solution(4, 7)}"
