# R-3data-manipulation-exercise

library("dplyr")

## Attaching package: 'dplyr'
## The following objects are masked from 'package:stats':
##
## filter, lag
## The following objects are masked from 'package:base':
##
## intersect, setdiff, setequal, union

library("tibble")

data(Gasoline, package = "plm")

gasoline = as_tibble(Gasoline) # make it tibble

filter(gasoline, year < 1970) # Create a subset of that only has data from the 1960s
# or: gasoline %>% filter(year < 1970)

filter(gasoline, year %in% c(1969,1970,1971,1972,1973)) # Create a subset that contains data from the years ranging from 1969 to 1973
# or: filter(gasoline, year %in% 1969:1973)
# or: filter(gasoline, year >= 1969, year <= 1973)
# or: filter(gasoline, between(year, 1969, 1973))

filter(gasoline, year %in% c(1969, 1973, 1977)) # Create a subset that contains data for the years 1969, 1973 and 1977

select(gasoline, country, year, lrpmg) # Create a dataset that contains only the columns country, year, lrpmg

select(gasoline, -country, -year, -lrpmg) # Create a dataset that does not contain the columns country, year, lrpmg

rename(gasoline, date = year) # Rename the column year to be called date.

select(gasoline, starts_with("l")) # Select all columns that start with “l”.

select(gasoline, country, year, contains("car")) # Select the columns country, year, and all columns that contain the letters “car”

? pull()
pull(gasoline, var=lrpmg) #  returns the lrpmg column of the dataframe as a vector in the correct format
str(pull(gasoline, var=lrmpg))

gas_country = group_by(gasoline, country) # Create a grouped data set that groups the data by country

gas_ungrouped = ungroup(gas_country)

avg_lgaspcar = mean(gas_country$lgaspcar) # Find the mean of lgaspcar by country. Call that variable avg_lgaspcar

summarise(gas_country, avg_lgaspcar = mean(lgaspcar))

filter(gas_country, country == "FRANCE") %>%
  summarise(avg_lgaspcar = mean(lgaspcar)) # Return a dataset that computes the mean of lgaspcar for france

sum_gas_country = summarise(gas_country,
                            avg_lgaspcar = mean(lgaspcar),
                            sd_lgaspcar = sd(lgaspcar),
                            min_lgaspcar = min(lgaspcar),
                            max_lgaspcar = max(lgaspcar)) # Compute the mean, standard deviation, min and max of lgaspcar by country

arrange(sum_gas_country, desc(avg_lgaspcar)) # Which country has the highest average gasoline consumption

filter(sum_gas_country, avg_lgaspcar == max(avg_lgaspcar) | avg_lgaspcar == min(avg_lgaspcar)) # Return a dataset that returns the countries with the highest and lowest average consumption

country_count = summarise(gas_country, count = n())
country_count # Add a variable count to the dataset that has the number of times each country appears in the data

spam = mutate(gasoline, my_exp = exp(lgaspcar + lincomep))
glimpse(spam) # Create a meaningless dataset called spam that is the exponential of the sum of lgaspcar and lincomep.

gas_ts = mutate(gas_country,
                lead_lgaspcar = lead(lgaspcar, order_by = year),
                lag_lgaspcar = lag(lgaspcar, order_by = year)) # Create the lead and lag of lgaspcar for each row of data. Call the new columns lead_lgaspcar and lag_lgaspcar

eu_countries <- c("austria", "belgium", "bulgaria", "croatia", "republic of cyprus",
                  "czech republic", "denmark", "estonia", "finland", "france", "germany",
                  "greece", "hungary", "ireland", "italy", "latvia", "lithuania", "luxembourg",
                  "malta", "netherla", "poland", "portugal", "romania", "slovakia", "slovenia",
                  "spain", "sweden", "u.k.")

EU_COUNTRIES = toupper(eu_countries)

gasoline = mutate(gasoline, in_eu = (country %in% EU_COUNTRIES))# Create a variable in_eu in the gasoline data which takes the value TRUE if a country is in the EU

medi = toupper(c("france", "italy", "turkey", "greece", "spain"))
ce = toupper(c("germany", "austria", "switzerl", "belgium", "netherla"))
anglo = toupper(c("canada", "u.s.a." , "u.k.", "ireland"))
nordic = toupper(c("denmark", "norway", "sweden"))
asia = toupper("japan") #  create a list for each region

gasoline = mutate(gasoline,
                  region = case_when(
                    country %in% medi ~ "Mediterranean",
                    country %in% ce ~ "Central Europe",
                    country %in% anglo ~ "Anglosphere",
                    country %in% nordic ~ "Nordic",
                    country %in% asia ~ "Asia" # now we will create the variable using mutate() and case_when()
                  )
) # create the variable using mutate() and case_when()

gasoline = mutate(gasoline,
                  country = recode_factor(country,
                                          NETHERLA = "NETHERLANDS",
                                          SWITZERL = "SWITZERLAND"
                  )
) # Use the functions mutate and recode to replace the name with the full country name

gas_country_1960 = filter(gasoline, year == 1960) %>%
  group_by(country) %>%
  summarise(avg_lgaspcar = mean(lgaspcar)
  ) # create a dataset only for 1960 where gas consumption is grouped by country

ntile(gas_country_1960$avg_lgaspcar, 4) 

gas_country_1960$quintile = ntile(gas_country_1960$avg_lgaspcar, 4)

gas_country_1960$decile = ntile(gas_country_1960$avg_lgaspcar, 9) # we repeat this for decile which defines 9 intervals

gasoline = left_join(gasoline, select(sum_gas_country, country, avg_lgaspcar), by = "country") %>%
  mutate(high_consumption = (lgaspcar > avg_lgaspcar)) %>%
  select(-avg_lgaspcar) # Create a variable high_consumption that takes the value TRUE if lgaspcar is higher than the yearly average for a given country



