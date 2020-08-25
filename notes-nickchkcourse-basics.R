help () # most important function!

# R is object-based not command-based --> R is all about manioulating objects

# object types: numeric (1), character ('hello'), ...

# vector #
a <- c(1,4,3) # create a vector
a[2] # gives me the second element of a
a[a<4] # gives the elemnets less than 4

# matrice (we like dataframes more) #
b <-c(4,5,6)
x <- cbind(a,b) 
x[3,2] # gives the element in col 3 and row 2
x[x[,1] <4,] # jsut gives the rows where a is less than 4

# data frames #
x <- as.data.frame(x) # turns x into a data frame
x$a < 4 # gives the same result as ine 16
x$c <- c("hello", "goodbye", "farewell")
x$c[3] # gives "farewell"
head(x) # look at top of data

df <- read.csv("") # bringing new data
df$NewYear <- df$Year + 1 # making new variable
df%one <- 1

df[df$firm == "ATB", ] # gives all the rows where frim == "ATB"

subset(df, firm == "ATB") # same as before

subset(df, firm == "ATB", select=c(Year, Firm, BV, DIV, EPS, NewYear)) # firts rows, second columns

# tibble #
