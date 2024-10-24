n <- 1000
a <- runif(n) 
b <- runif(n) 
c <- 0 

# Dot product with for-loop
time_loop <- system.time({
  for (i in 1:n) {
    c <- c + a[i] * b[i]
  }
})["elapsed"] 

cat("value_loop:", c, "\n")
cat("time_loop:", time_loop, "seconds\n")

# Dot product with vectorization
time_vec <- system.time({
  cc <- sum(a * b)
})["elapsed"] # Get the elapsed time

cat("value_vec:", cc, "\n")
cat("time_vec:", time_vec, "seconds\n")

# Compare the results
norm_difference <- (sum((c - cc))) 
cat("Difference (norm):", norm_difference, "\n") 

# Measuring the speed-up
Speedup <- time_loop["elapsed"]  / time_vec["elapsed"] 

cat("Speed-up:", Speedup, "\n")

