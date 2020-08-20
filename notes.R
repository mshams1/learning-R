### subsetting vectors ###

# three types of index vectors: (1) logical, (2) integres and (3) named

# (1) logical
y <- x[!is.na(x)] # gives a vector containing all of the non-NA values from x
y > 0             # gives us a vector of logical values the same length as y, with TRUEs corresponding to values of y that are greater than zero and FALSEs corresponding to values of y that are less than or equal to zero
y[y > 0] # A vector of all the positive elements of y

# (2) integres
# R uses 'one-based indexing', which (you guessed it!) means the first element of a vector is considered element 1
x[2] # gives 2nd member of x
x[c(2,10)] # gives the 2nd and 10th members of x

# (3) named vectors
vect <- c(foo=11,bar=2,norf=NA)
vect["bar"] 3 gives the '2'


