def loops(u)
  r = rand(10000)           # Get a random number 0 <= r < 10k
  a = Array.new(10000, 0)   # Array of 10k elements initialized to 0

  10_000.times do |i|       # 10k outer loop iterations
    10_000.times do |j|     # 10k inner loop iterations, per outer loop iteration
      a[i] += j % u         # Simple sum
    end
    a[i] += r               # Add a random value to each element in array
  end

  a[r]                       #  Return a single element from the array
end
