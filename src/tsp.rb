def total_cost(mask, pos, n, cost, memo)
  # Basis: jika semua kota sudah dikunjungi, kembali ke kota awal 0
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

# test case 1
cost = [
  [0, 10, 15, 20],
  [10, 0, 35, 25],
  [15, 35, 0, 30],
  [20, 25, 30, 0]
]

result = tsp(cost)
puts "Biaya perjalanan terpendek TSP adalah: #{result}"

# test case 2
cost = [
  [0, 29, 20, 21],
  [29, 0, 15, 17],
  [20, 15, 0, 28],
  [21, 17, 28, 0]
]

result = tsp(cost)
puts "Biaya perjalanan terpendek TSP adalah: #{result}"

# test case 3
cost = [
  [0, 10, 15],
  [10, 0, 35],
  [15, 35, 0]
]

result = tsp(cost)
puts "Biaya perjalanan terpendek TSP adalah: #{result}"

# test case 4 with large matrix
cost = Array.new(20) { Array.new(20, 0) }
(0...20).each do |i|
  (0...20).each do |j|
    cost[i][j] = rand(1..100) if i != j
  end
end

result = tsp(cost)
puts "Biaya perjalanan terpendek TSP untuk matriks besar adalah: #{result}"
