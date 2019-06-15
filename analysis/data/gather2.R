#############
# Gather file for Breweries.csv
# Authors: Kevin Thompson and Stuart Miller
# Last updated June 15, 2019
#############

# read in dataset
brewery_data <- read.csv("Breweries.csv")

# correct data types
brewery_data$Brew_ID <- as.character(brewery_data$Brew_ID)
brewery_data$Name <- as.character(brewery_data$Name)

# change Brew_ID column name to Brewery_id for consistency between datasets
colnames(brewery_data)[colnames(brewery_data) == "Brew_ID"] <- "Brewery_id"

# rename names column
colnames(brewery_data)[colnames(brewery_data) == "Name"] <- "Brewery_name"
