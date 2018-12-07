
# how can we look at the air quality data in a manageable way?

#First what is the information about? Let's check column names
colnames(dat)

# head asks for the first few rows, and the column names
# remember, ?head
head(dat)

# The top right of Rstudio shows us what's in our working environment. WE can see the table dat has 2769 rows.
# What else does it show?
# does it show only boroughs? Other types of toxins than benzene?

# so far, we've only used base R
# for these more difficult questions, let's load dplyr to make our lives easier:
library(dplyr)

# dplyr has a grammar of "pipes"
# pipes are like plus signs
# just as a plus signs are written as "+"
# pipes are written as "%>%"

# On the left side of a pipe is a data table;
# on the right side is a request to do something.
# let's see how many different geographies we have information on
# by asking dplyr to count them :P
dat %>% count(geo_entity_name)

# what about toxin indicators?
dat %>% count(name)

# geographic levels?
dat %>% count(geo_type_name)

# what does this tell us? we have 54 citywide indicators,
# 270 borough-level one (54 * 5 = 270, so probably the same citywide indicators but broken up by boro)

# what about the other ones?
# let's look at a few rows of "UHF42" and "CD"
dat %>%
  filter(geo_type_name == "CD") %>%
  head()


# (notice we did ~two~ things to the starting table. First we filtered, then we asked to see just the beginning please)
# What are the geo entity names?
# what about UHF42?
dat %>%
  filter(geo_type_name == "UHF42") %>%
  head()


# what is there to notice? what do we still want to learn?
dat %>%
  filter(geo_type_name == "CD") %>%
  count(name)
  
dat %>%
  filter(geo_type_name == "CD") %>%
  count(geo_entity_name)



dat %>%
  filter(geo_type_name == "UHF42") %>%
  count(name)
  
dat %>%
  filter(geo_type_name == "UHF42") %>%
  count(geo_entity_name)

# (if it gets cut off too early, and we want to see more, we can ask R to turn the table into a "dataframe" at the end)
dat %>%
  filter(geo_type_name == "UHF42") %>%
  count(name) %>%
  data.frame()

# and say we want to look at indicator ID alongside name:
dat %>%
  filter(geo_type_name == "UHF42") %>%
  count(indicator_id,
        name) %>%
  data.frame()


# oh wow.
# Choose one you're interested in.
# let's make a table that is filtered down, to just that one.
# can you figure out how?


# (call it "my.dat")