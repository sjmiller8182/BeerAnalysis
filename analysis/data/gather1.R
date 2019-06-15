#############
# Gather file for Beers.csv
# Authors: Kevin Thompson and Stuart Miller
# Last updated June 15, 2019
#############

#read in dataset
beer_data <- read.csv("analysis/data/Beers.csv")


# Names and IDs should be read in as characters, not factors
beer_data$Name <- as.character(beer_data$Name)
beer_data$Beer_ID <- as.character(beer_data$Beer_ID)
beer_data$Brewery_id <- as.character(beer_data$Brewery_id)
beer_data$Ounce_groups <- as.factor(beer_data$Ounces)
beer_data <- subset(beer_data, select = -c(Ounces))
