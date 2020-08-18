# R-1basics

#Basics

# Iterations
## for loops
### looping over numeric indices
my_df = tibble::tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

median(my_df$a)
median(my_df$b)
median(my_df$c)
median(my_df$d)

output = vetor("double", ncol(my_df))
for (i in seq_along(my_def)) {
  output[i]=median(my_df[[i]])
}
output

### looping over elements
for(x in my_df) {
  print(median(x))
}

### looping over names
for (name in names(my_df)) {
  cat("Median for variable ", name, " is: ", median(my_df[[name]]), '\n', sep='')
}

# Split, apply, combine with map functions
my_df=tibble::(
  a=rnorm(10),
  b=c(rnorm(9), NA),
  c=rnorm(10),
  d=rnorm(10)
)

map_dbl(my_def, median)
map_dbl(my_def, mean)
map_dbl(my_def, sd)

map_chr(my_df, mean, na.rm=TRUE)

## syntax (compute for b as well)
map_dbl(my_df, mean, na.rm = TRUE)

## map2 (to iterate over two lists) and pmap (to iterate over more than two lists)
mu = list(0,0,0,0)
sd = list(1,5,10,20)

my_fancy_df = map2(mu,sd,rnorm, n=20)
my_fancy_df = set_names(my_fancy_df, c('a','b','c','d'))
my_fancy_df = tibble :: as_tibble(my_fancy_df)

mu = list(1,2,3,4)
sd = list(1,10,15,20)
n = list(1,2,3,4)

args = list(n,mu,sd)

str(pmap(args, rnorm))
