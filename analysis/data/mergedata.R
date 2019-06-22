############
# R file for merging data after they are gathered in gather1.R and gather2.R
# Authors: Kevin Thompson and Stuart Miller
# Last updated June 15, 2019
############
library(dplyr)
library(naniar)


merged_data <- merge(brewery_data, beer_data, by="Brewery_id", all=FALSE)
nabular_data <- merged_data %>%
                  bind_shadow()
  
