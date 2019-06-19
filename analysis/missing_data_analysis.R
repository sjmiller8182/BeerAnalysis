#################
# Missing Data Analysis
# Authors: Kevin Thompson and Stuart Miller
# Last updated June 16, 2019
#################

library(tidyverse)
library(naniar)

# bind merged data to shadow matrix to create nabular dataset
nabular_merged <- merged_data %>%
                    bind_shadow()



# Missingness in IBU tends to occur between 5% and 10% alcohol level, which is where most of the data is anyway
nabular_merged %>%
  ggplot(aes(x = ABV, y = IBU)) +
  geom_miss_point()

# distribution of Alcohol By Volume similar for Missing and Non-Missing IBU
nabular_merged %>%
  ggplot(aes(x=ABV, color = IBU_NA)) +
  geom_histogram() +
  facet_wrap(~IBU_NA)