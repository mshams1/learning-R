# simulations #

results <- data.frame(xcoef=NA, xse=NA)

for (i in 1:5000) {
  error1 <- rnorm(5000)
  x = error1 + rnorm(5000)
  y = 1.5*x + error1 + rnorm(5000) 

olsmodel <- lm(y-x)

  results[i,  ] <- c(coef(olsmodel)[['x']],
                     summary(olsmodel)$coefficients[2,2])
}

plot(density(results$xoef))
summary(olsmodel)

# tidyverse #

#Load packages
library(foreign)
library(tidyverse)
library(stargazer)
library(haven)

#Read Wooldridge data
wage1 <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/wage1.dta")

#Create a tibble version of wage1
wage1.t <- as.tibble(wage1)

#Look at the data with head
head(wage1)
head(wage1.t)

#Use glimpse instead
glimpse(wage1.t)

#Generally, treat it like a data frame
mean(wage1.t$wage)

#Get summary stats with stargazer - we need to make it a data.frame
stargazer(as.data.frame(wage1.t),type='text')

#Read in Wooldridge data as a tibble directly
wage1haven <- read_dta("http://fmwww.bc.edu/ec-p/data/wooldridge/wage1.dta")

