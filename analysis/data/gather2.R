#############
# Gather file for Breweries.csv
# Authors: Kevin Thompson and Stuart Miller
# Last updated June 15, 2019
#############

# read in dataset
brew_data <- read.csv("analysis/data/Breweries.csv")

#correct data types
brew_data$Brew_ID <- as.character(brew_data$Brew_ID)
brew_data$Name <- as.character(brew_data$Name)
