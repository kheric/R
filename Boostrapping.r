#####Bootstrapping/Resampling (Bagging)#####

###Bootstrapping a Single Statistic (k=1)###
# Bootstrap 95% CI for R-Squared
library(boot)
# function to obtain R-Squared from the data 
rsq <- function(formula, data, indices) {
  d <- data[indices,] # allows boot to select sample 
  fit <- lm(formula, data=d)
  return(summary(fit)$r.square)
} 
# bootstrapping with 1000 replications 
results <- boot(data=mtcars, statistic=rsq, 
  	 R=1000, formula=mpg~wt+disp)
# view results
results 
plot(results)
# get 95% confidence interval 
boot.ci(results, type="bca")

###Bootstrapping Several Statistics (k>1)###
# Bootstrap 95% CI for regression coefficients 
library(boot)
# function to obtain regression weights 
bs <- function(formula, data, indices) {
  d <- data[indices,] # allows boot to select sample 
  fit <- lm(formula, data=d)
  return(coef(fit)) 
} 
# bootstrapping with 1000 replications 
results <- boot(data=mtcars, statistic=bs, R=1000, formula=mpg~wt+disp)
# view results
results
plot(results, index=1) # intercept 
plot(results, index=2) # wt 
plot(results, index=3) # disp 
# get 95% confidence intervals 
boot.ci(results, type="bca", index=1) # intercept 
boot.ci(results, type="bca", index=2) # wt 
boot.ci(results, type="bca", index=3) # disp
