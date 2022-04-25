# review your dataframe and check for additional surprises

my.dat %>% head()


my.dat %>% count(geo_type_name)

all.dat %>% count(Measure)

#notice we have two data ranges. Let's just worry about one
my.dat %>% count(year_description)

my.dat <-
  my.dat %>% filter(year_description == "2009-2011")


# let's make UHF-level map
# we can trim our data to just the "UHF rows"
# Again, can you figure out how?


# To do that, we need a shapefile
# a shapefile is exactly what it sounds like

# Google took me here to get a "UHF shapefile" ---
# https://www1.nyc.gov/site/doh/data/health-tools/maps-gis-data-files-for-download.page
# notice it's from the department of health, the agency that got together our dataset.

# The site also alerted me to the meaning of "UHF"
# ..."United Hospital Fund neighborhoods" !!!!

# let's download, put it somewhere sensible, and tell R where that is:
shapefile.path <- "data/shapefile/UHF_42_DOHMH_2009.shp"

# to read the shapefile, we'll need the sf library
library(sf)

# all "sf" commands begin with "st"

# (R has it's quirks)

# to store a shapefile, we can do:
shp <- st_read(shapefile.path)

