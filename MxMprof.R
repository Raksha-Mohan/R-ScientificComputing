library(profvis)

profvis({
  rm(list = ls())
  
  n <- 1000  
  A <- matrix(runif(n * n), nrow = n, ncol = n)  
  B <- matrix(runif(n * n), nrow = n, ncol = n)  
  C <- matrix(0, nrow = n, ncol = n)  
  CC <- matrix(0, nrow = n, ncol = n) 
  
  # For Loop 
  tf <- system.time({
    for (i in 1:n) {
      for (j in 1:n) {
        for (k in 1:n) {
          C[i, j] <- C[i, j] + A[i, k] * B[k, j]
        }
      }
    }
  })
  cat("For loop time:", tf["elapsed"])
  
  # Partial vectorized approach
  tpv <- system.time({
    for (j in 1:n) {
      CC[, j] <- A %*% B[, j]
    }
  })
  cat("Partial Vector time:", tpv["elapsed"])
  
  # Fully vectorized approach
  tv <- system.time({
    CCC <- A %*% B
  })
  cat("Vector time:", tv["elapsed"])
  
  # Comparing results
  cat("Difference(C-CC):" ,(norm(C - CC, type = "2")))
  cat("Difference(CC-CCC):" ,(norm(C - CCC, type = "2")))
  
  # Calculating Speedups
  Speedup_for <- tf["elapsed"] / tpv["elapsed"]
  Speedup_Part.Vec <- tf["elapsed"] / tv["elapsed"]
  Speedup_Vec <- tpv["elapsed"] / tv["elapsed"]
  cat("Speedup_for:", Speedup_for)
  cat("Speedup_Part.Vec:", Speedup_Part.Vec)
  cat("Speedup_Vec:", Speedup_Vec)
  
})
