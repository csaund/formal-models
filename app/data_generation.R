## playing with data generation

library(MASS)
library(sn)
library(mvtnorm) 
library(ggplot2)

corr <- 0.9

get_correlated_data <- function(num_samples, correlation) {
  data <- rmvnorm(n=num_samples,
                  mean=c(40,5),
                  sigma=matrix(c(30, correlation * sqrt(50), correlation * sqrt(50), 5), 2, 2))
  d <- data.frame(data)
  colnames(d) <- c("age", "litres_irnbru_per_month")
  return(d)
}

d <- get_correlated_data(200, 1)

plot(d)



m <- matrix(c(3, corr * sqrt(50), corr * sqrt(50), 10), 2, 2)



## using copula theory -- this one works much better
complement <- function(y, rho, x) {
  if (missing(x)) x <- rnorm(length(y)) # Optional: supply a default if `x` is not given
  y.perp <- residuals(lm(x ~ y))
  rho * sd(y.perp) * y + y.perp * sd(y) * sqrt(1 - rho^2)
}


scale_values <- function(data, tmin, tmax) {
  rmin <- min(data)
  rmax <- max(data)
  scaled <- ((data - rmin) / (rmax - rmin)) * (tmax - tmin) + tmin
  return(scaled)
}

generate_data_copula <- function(num_samples, correlation) {
  ages <- runif(num_samples, min=0, max=87)
  vals <- 1:num_samples # Optional
  y = as.vector(sapply(correlation, function(correlation) complement(ages, correlation, vals)))
  litres_per_month = scale_values(y, 0, 40)
  X <- data.frame(litres_per_month,
                  correlation=ordered(rep(signif(correlation, 2))),
                  ages=ages) 
  return(X)
}

e <- generate_data_copula(200, 0.4)

ggplot(e, aes(ages,litres_per_month, group=correlation)) + 
  geom_smooth(method="lm", color="Black") + 
  #geom_rug(sides="b") + 
  geom_point(aes(fill=correlation), alpha=1/2) 


