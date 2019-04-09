## playing with data generation

library(MASS)
library(sn)
library(mvtnorm) 



# We will use the command mvrnorm to draw a matrix of variables

# Let's keep it simple, 
mu <- c(25,3)
Sigma <- matrix(.7, nrow=2, ncol=2) + diag(2)*.3

rawvars <- mvrnorm(n=10000, mu=mu, Sigma=Sigma)

cov(rawvars); cor(rawvars)

# We can see our normal sample produces results very similar to our 
#specified covariance levels.

# No lets transform some variables
pvars <- pnorm(rawvars)

# Through this process we already have 
cov(pvars); cor(pvars)
# We can see that while the covariances have dropped significantly, 
# the simply correlations are largely the same.

plot(rawvars[,1], pvars[,2], main="Normal of Var 1 with probabilities of Var 2") 

expvars <- qexp(pvars)
sknormvars <- qsn(pvars, 5, 2, 5)
cor(expvars, rawvars)

hist(sknormvars, breaks=20) 


a <- rmvnorm(n=10000,mean=c(20,40),sigma=matrix(c(5,0.6*sqrt(50), 
                                                  0.6*sqrt(50),10),2,2)) 

plot(a)


plot_correlated_data <- function(num_samples, correlation) {
  data <- rmvnorm(n=num_samples,
                  mean=c(20,40),
                  sigma=matrix(c(5, correlation * sqrt(50), correlation * sqrt(50), 10), 2, 2))
  return(data)
}

plot(plot_correlated_data(200, 0.8))
