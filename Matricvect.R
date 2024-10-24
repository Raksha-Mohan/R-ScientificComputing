rm(list = ls())

n <- 100
A <- matrix(runif(n * n), nrow = n, ncol = n) 
x <- runif(n)  
b <- numeric(n)
bb <- numeric(n)

# Using For loop
tf <- system.time({
for (i in 1:n) {
  for (j in 1:n) {
    b[i] <- b[i] + A[i, j] * x[j]
  }
}
  })
cat("loop time:", tf["elapsed"])

# Partial vectorization
tpv <- system.time({
for (i in 1:n) {
  bb[i] <- A[i, ] %*% x
}
})
cat("Partial Vector time:", tpv["elapsed"])

# Complete vectorization
tv <- system.time({
bbb <- A %*% x
})
cat("Vector time:", tv["elapsed"])

# Comparing results
cat("Difference (b - bb):" ,(norm(b - bb, type = "2")))
cat("Difference (bb - bbb):" ,(norm(b - bbb, type = "2")))

# Calculating Speedups
Speedup_for <- tf["elapsed"] / tpv["elapsed"]
Speedup_Part.Vec <- tf["elapsed"] / tv["elapsed"]
Speedup_Vec <- tpv["elapsed"] / tv["elapsed"]
cat("Speedup_for:", Speedup_for)
cat("Speedup_Part.Vec:", Speedup_Part.Vec)
cat("Speedup_Vec:", Speedup_Vec)

