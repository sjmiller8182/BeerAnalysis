#############
# Gather file for Breweries.csv
# Authors: Kevin Thompson and Stuart Miller
# Last updated June 15, 2019
#############
library(tidyverse)


# read in dataset
brewery_data <- read_csv("Breweries.csv", col_types = 
                           cols(
                             Brew_ID = col_character(),
                             Name = col_character(),
                             City = col_character(),
                             State = col_character()
                           ))

# Rename columns for merging
colnames(brewery_data)[colnames(brewery_data) == "Brew_ID"] <- "Brewery_id"
colnames(brewery_data)[colnames(brewery_data) == "Name"] <- "Brewery_name"
