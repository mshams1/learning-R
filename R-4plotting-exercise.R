library(readr)
library(dplyr)
library(ggplot2)
library(magrittr)

setwd('/mnt/c/Users/mahdi/Documents/GitHub/2020-uzh-course-material/15-R-plotting/exercise/')
df <- read_csv("data/EconomistData.csv")

glimpse(df)

library(janitor)
df %<>% clean_names("snake") # Convert all columns names to snakecase (i.e. my_variable)

### One-variable graph ###
df %>%
  ggplot() +
  geom_histogram(aes(hdi),
                 bins = 20
  ) #  Create a histogram of the human development index. Customize the number of bins to make the plot look nicer than the default

df %>%
  ggplot(aes(cpi, fill = region)) +
  geom_density() #  a density plot of the HDI (plotting the densities by region)

df %>%
  ggplot(aes(hdi)) +
  geom_density(fill = "blue") +
  facet_wrap(vars(region), ncol = 2) # separate plots per region

### two-variable graph ###

df %>%
  ggplot(aes(x = cpi, y = hdi)) +
  geom_point() # the simple scatter plot

df %>%
  ggplot(aes(x = cpi, y = hdi)) +
  geom_point(aes(color = region)) # by region

df %>%
  ggplot(aes(x = cpi, y = hdi)) +
  geom_point(aes(color = region, size = hdi )) # Color the points by region and make the size of the point vary by HDI

df %>%
  ggplot(aes(x = cpi, y = hdi)) +
  geom_point() +
  geom_smooth() # Add a loess smoother

df %>%
  ggplot(aes(x = cpi, y = hdi)) +
  geom_point() +
  geom_smooth(se= FALSE, method = "lm", color = "red") # Add a linear smoother

df %>%
  ggplot(aes(x = cpi, y = hdi)) +
  geom_point(aes(color = region, size = hdi )) +
  geom_smooth(se= FALSE,
              method = "lm",
              formula = y ~ x + log(x),
              color = "red") # Add the line y ~ x + log(x), without the confidence interval. Color the line red

library(ggrepel)

df %>%
  ggplot(aes(x = cpi, y = hdi)) +
  geom_point(aes(color = region),
             shape = 1, size = 2.5, stroke = 1.25) +
  geom_smooth(se= FALSE,
              method = "lm",
              formula = y ~ x + log(x),
              color = "red") +
  geom_text_repel(aes(label = country)) # Use geom_text() to add country names to our plot

points_to_label <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                     "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                     "India", "Italy", "China", "South Africa", "Spane",
                     "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                     "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                     "New Zealand", "Singapore")

df %>%
  ggplot(aes(x = cpi, y = hdi)) +
  geom_point(aes(color = region),
             shape = 1, size = 2.5, stroke = 1.25) +
  geom_smooth(se= FALSE,
              method = "lm",
              formula = y ~ x + log(x),
              color = "red") +
  geom_text_repel(aes(label = country),
                  color = "gray20",
                  data = filter(df, country %in% points_to_label),
                  force = 10) # We might not want all the points labelled