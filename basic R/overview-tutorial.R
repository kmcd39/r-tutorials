rm(list = ls())

mtcars
# use a common demonstation dataset, bundled in R.
cars <- mtcars

# look at first 5 rows of dataset
head(cars)

# (what does that function do?)
#?head

# we can also look at documentation for the dataset we loaded
#?mtcars

# use base R to check the average mpg
mean(cars$mpg)

# use base R to plot wt to mpg
plot(cars$wt, cars$mpg)

# filtering in base R:
cars[cars$cyl == 6 &
       cars$mpg > 20, ]

# (damn big cars are wasteful)

efficient.cars <- cars %>% filter(mpg > 25)

# hotkey for the assignment operator "<-" is alt+- 


# tidyverse --------------------------------------------------------------------


# (hit ctrl-shift-R to creat a section label. Notice it can give you a nice code
# outline  in Rstudio. View this by hitting the little button on the top-right of
# this pane.)

# let's load tidyverse
# install.packages('tidyverse')
library(tidyverse)

# we can make cars a "tibble" or tidy table, and it displays slightly differently
cars
cars <- tibble(cars)
cars

# nested function logic:
mean(filter(cars, mpg > 20)$mpg)

#' tidyverse piped logic:
#'
#' ctrl+shift+M is pipe hotkey
cars %>% 
  filter(mpg > 20) %>% 
  pull(mpg) %>% 
  mean()



# a key component of tidyverse syntax is the pipe: %>%
# pipe passes a componenent into a function. So instead of
mean(cars$mpg)
# we can also write
cars$mpg %>% mean()
# or even
cars %>% .$mpg %>% mean()


# Now it's much easier to see the average MPG for different cylinders
cars %>% 
  group_by(cyl) %>% 
  summarise(mean.mpg = mean(mpg),
            count = n() )

# we summarised the cars dataset to something with mean miles per gallon by number of
# cylinders, and the count of rows in the dataset with each number of cylinders.


# ploting ----------------------------------------------------------------------


# use ggplot -- tidyverse visualization technique to make a more complex plots

# start with scatter plot
ggplot(cars
       ,aes(x = wt
            ,y = mpg)) +
  geom_point(aes(color = factor(cyl))) 


p <- 
  ggplot(cars
       ,aes(x = wt
            ,y = mpg)) +
  geom_smooth( color = '#008080'
               ,size = 2
               #, method = 'lm'
               ) +
  geom_point( aes(color = factor(cyl)) ) 

p

# that should change based on a variable in the dataset will be wrapped in aes(),
# other qualities like color or size or opacity (alpha), which may be static, should
# be outside of aes()

# let's improve the labeling somewhat, by adding to the plot object "p" we just
# created
p +
  scale_x_continuous(name = 'weight') +
  scale_color_discrete(name = 'cylinders') +
  labs(title = 'Miles per gallon as a function of car weight'
     ,subtitle = 'Points represent a car make, colored by engine cylinders. Smoothed line shown.')

# a messy interactive version (if you want to use 1 function from a package without
# loading the entire package, use "::")
plotly::ggplotly(p)


