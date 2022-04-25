# define a my.dat
my.dat <- dat %>%
  filter(indicator_id == 655)

# trim my.dat to UHF's
my.dat <- my.dat %>%
  filter(geo_type_name == "UHF42")


# other step to prep "my.dat" :

my.dat <-
  my.dat %>% filter(year_description == "2009-2011")


my.dat$data_valuemessage <- as.numeric(as.character(my.dat$data_valuemessage))

