### these commands install the packages we'll use.
# see the handout for more information

install.packages("sf") # sf helps us deal with spatial data
install.packages("dplyr") # dplyr helps us look at data, full stop
install.packages("ggplot2") # ggplot helps us make cool visualizations.


### download the necessary data!

# hopefully, you started a new R project-- the wd (working directory) should be where you made the project
# This is your base directory, so paths will be "relative" paths starting from this folder
getwd() 

# if you're not sure what a command is, you can ask R by typing a question mark before it!
?getwd


# R is fun and visual, so we use arrow signs to "assign variables"
# The following line of code defines an object called "download.link"
# as is the link i took from the opendata site (if you click the download button here:
# https://data.cityofnewyork.us/Environment/Air-Quality/c3uy-2p5r
download.link <- "https://data.cityofnewyork.us/api/views/c3uy-2p5r/rows.csv?accessType=DOWNLOAD"


# now we can reference that
read.csv(download.link)

# what was that output? let's assign it to another variable, and we'll look at in a sensible way in the next script
dat <- read.csv(download.link)

# "dat" is now a table, saved in our "working environment" that we downloaded from the City's opendata portal.