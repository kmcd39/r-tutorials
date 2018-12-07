# sf turned the shapefile into a dataframe (what R calls the basic table format)
# The sf dataframe ALSO has spatial data, but we can still look at it the same way we were looking at the other tables
shp %>% colnames()
shp %>% head()

my.dat %>% head()

### technical step:
# this deals with converting between "data types" in R
my.dat$data_valuemessage <- as.numeric(as.character(my.dat$data_valuemessage))

# to join the health data we decided we care about with the shapefile
# we can use "left_join" from dplyr

all.dat <-
  my.dat %>%
  left_join(shp,
            by = c("geo_entity_id" = "UHFCODE"))

# (the "by" line tells which column to match with which)

all.dat %>% head()


## at this point, let's start looking at pictures.

## load ggplot for that
library(ggplot2)


# people sometimes talk about "dplyr" as working with a "grammar" of data manipulation
# and ggplot2 as trying to create a "grammar" of graphics (specifically, of data viz)

# start with telling ggplot a dataframe
# then tell it what to graph.
# you can add layer after layer
# and then worry about legends and making it cute.

# All the layers will be called "geoms" for geometry
# all geometries will have "aesthetics"
# wrap aesthetic/visual elements that will be affected by a data element in an aes function
# (itself wrapped in the geom object)
# You can also define visual elements outside of the aes function.




## this visualizes the range of attributable asthma hospitalizations across neighborhoods
ggplot(my.dat) +
  geom_density(aes(x = data_valuemessage), #the x value is dependent on the data
               fill = "turquoise") # but not the color



## How are they distributed by borough?
ggplot(all.dat) +
  geom_density(aes(x = data_valuemessage,
                   fill = BOROUGH)) # (breaks data up by borough, does fill color based on borough)

# (notice we changed the dataframe we started with, to include the borough information)




### And finally!
### because maps are fun:

ggplot(all.dat) +
  geom_sf(aes(fill = data_valuemessage))


# But also let's make it cute
ggplot(all.dat) +
  geom_sf(aes(fill = data_valuemessage)) +
  
  # add labels! (labs is short for labels.)
  # \n is endline
  labs(title = "Children Asthma Hospitalization Rate",
       fill = "Attributable Hospitalization\nRate") +
  
  # (this tell ggplot to leave out the long + latitute information in the map)
  coord_sf(datum = NULL) +
  
  # ggplot has different built-in themes. you can also write your own.
  # for now, the black-and-white theme can get rid of our grey background
  theme_void() +
  
  # experiment with color changes (uncomment the ones you want to try, type your own)
  
  #scale_fill_viridis_c()
  
  scale_fill_gradient(#high = "red"
                      #high = "mediumorchid"
                      #high = "#a9f027"
    #, guide = "legend" 
    )


?scale_fill_gradient
?theme

# and lets save for perpetuity
ggsave("myplot.png",
       scale = 1.2)
