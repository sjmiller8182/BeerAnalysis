#############
# Gather file for Breweries.csv and Abbreviations.csv
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

abbreviation_data <- read_csv("Abbreviations.csv", col_types = 
                                cols(
                                  State = col_character(),
                                  Unabbreviated = col_character(),
                                  CensusDivision = col_factor()
                                ))

# Rename columns for merging
colnames(brewery_data)[colnames(brewery_data) == "Brew_ID"] <- "Brewery_id"
colnames(brewery_data)[colnames(brewery_data) == "Name"] <- "Brewery_name"
