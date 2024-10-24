library(parallel) 

#Defining function and input values
f <- function(x) sin(3 * pi * cos(2 * pi * x) * sin(pi * x))
a <- -3
b <- 5
n <- 4^9
x0 <- seq(a, b, length.out = n) # Vector containing initial starting points
q <- numeric(length(x0)) # Preallocate a vector for storing roots

#Function to find the root values
froot <- function(f, x) {
  llimit <- x - 0.01
  ulimit <- x + 0.01
  if (f(llimit) * f(ulimit) < 0) { # Check if signs are opposite
    return(uniroot(f, lower = llimit, upper = ulimit)$root)
  } else {
    return(NA) 
  }
}

# Series for loop
tser <- system.time({
  for (i in seq_along(x0)) {
    q[i] <- froot(f, x0[i])
  }
})
cat("ts:", tser["elapsed"], "\n")

#Parallel computation
workers <- detectCores()
num_cores <- min(workers - 1, 4)
c <- makeCluster(num_cores)
clusterExport(c, list("f", "froot"))


tpar <- system.time({
  q_parallel <- parLapply(c, x0, function(x) froot(f, x))
})
cat("tp:", tpar["elapsed"], "\n")

stopCluster(c)

#Finding speedup and efficincy
Sp <- tser["elapsed"] / tpar["elapsed"]
cat("Sp:", Sp)

Ef <- Sp / num_cores * 100
cat("Ef:",Ef)
