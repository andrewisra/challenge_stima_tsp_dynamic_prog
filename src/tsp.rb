require 'benchmark'

def print_matrix(matrix)
  matrix.each do |row|
    puts row.map { |v| v.to_s.rjust(4) }.join(' ')
  end
end

def total_cost(mask, pos, n, cost, memo)
  if mask == (1 << n) - 1
    return cost[pos][0]
  end

  return memo[[pos, mask]] if memo.key?([pos, mask])

  ans = Float::INFINITY

  (0...n).each do |city|
    if (mask & (1 << city)) == 0
      new_mask = mask | (1 << city)
      cost_to_city = cost[pos][city] + total_cost(new_mask, city, n, cost, memo)
      ans = cost_to_city if cost_to_city < ans
    end
  end

  memo[[pos, mask]] = ans
  ans
end

def tsp(cost)
  n = cost.length
  memo = {}
  total_cost(1, 0, n, cost, memo)
end

def run_test_case(cost, description)
  puts "===== #{description} ====="
  puts "Matriks jarak:"
  print_matrix(cost)
  time = Benchmark.realtime do
    result = tsp(cost)
    puts "Biaya perjalanan terpendek TSP adalah: #{result}"
  end
  puts "Waktu eksekusi: #{(time * 1000).round(2)} ms\n\n"
end

# Test case 1
cost1 = [
  [0, 5, 9],
  [5, 0, 2],
  [9, 2, 0]
]
run_test_case(cost1, "Test case 1 (3 kota)")

# Test case 2
cost2 = [
  [0, 3, 1, 5],
  [2, 0, 4, 2],
  [3, 6, 0, 7],
  [5, 2, 3, 0]
]
run_test_case(cost2, "Test case 2 (4 kota)")

# Test case 3
cost3 = [
  [0, 10, 10, 10, 100],
  [10, 0, 20, 20, 100],
  [10, 20, 0, 15, 100],
  [10, 20, 15, 0, 100],
  [100, 100, 100, 100, 0]
]
run_test_case(cost3, "Test case 3 (5 kota, ada jarak jauh)")

# Test case 4
cost4 = [
  [0]
]
run_test_case(cost4, "Test case 4 (1 kota)")

# Test case 5: matriks besar 20x20
cost5 = Array.new(20) { Array.new(20, 0) }
(0...20).each do |i|
  (0...20).each do |j|
    cost5[i][j] = rand(1..100) if i != j
  end
end
run_test_case(cost5, "Test case 5 (20 kota, matriks besar acak)")
