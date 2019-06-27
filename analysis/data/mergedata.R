############
# R file for merging data after they are gathered in gather1.R and gather2.R
# Authors: Kevin Thompson and Stuart Miller
# Last updated June 15, 2019
############
library(dplyr)
library(naniar)


merged_data <- merge(brewery_data, beer_data, by="Brewery_id", all=FALSE)
merged_data <- merge(merged_data, abbreviation_data, by="State", all=FALSE)
merged_data <- rename(merged_data, region = Unabbreviated)
merged_data$Ounces <- factor(merged_data$Ounces)
nabular_data <- merged_data %>%
  bind_shadow()
