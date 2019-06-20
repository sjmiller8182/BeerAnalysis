#############
# Gather file for Beers.csv
# Authors: Kevin Thompson and Stuart Miller
# Last updated June 20, 2019
#############
library(tidyverse)
library(naniar)

#read in dataset
beer_data <- read.csv("Beers.csv")


get_relevant_words <- function(character_val) {
  for(i in (-1:-3)) {
    last_word = word(character_val, i)
    if(is.na(last_word) | is.null(last_word)) {
      return(NA)
    }
    else if(str_detect(last_word, "[^)]$") & str_detect(last_word, "^((?![Bb]eer).)*$")) {
      return(last_word)
    }
  }
}


# Names and IDs should be read in as characters, not factors
beer_data$Name <- as.character(beer_data$Name)
beer_data$Beer_ID <- as.character(beer_data$Beer_ID)
beer_data$Brewery_id <- as.character(beer_data$Brewery_id)
beer_data$Ounce_groups <- as.factor(beer_data$Ounces)
beer_data$Style <- as.character(beer_data$Style)
beer_data <- subset(beer_data, select = -c(Ounces))

# Rename name column
colnames(beer_data)[colnames(beer_data) == "Name"] <- "Beer_name"

beer_data <- beer_data %>%
              replace_with_na(replace = list(Style = c("", " "))) %>%
              rowwise() %>%
              mutate(ShortStyle = get_relevant_words(Style))


get_relevant_words <- function(character_val) {
  for(i in (-1:-3)) {
    last_word = word(character_val, i)
    if(is.na(last_word) | is.null(last_word)) {
      return(NA)
    }
    else if(str_detect(last_word, "[^)]$") & str_detect(last_word, "^((?![Bb]eer).)*$")) {
      return(last_word)
    }
  }
}
  

