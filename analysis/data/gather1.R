#############
# Gather file for Beers.csv
# Authors: Kevin Thompson and Stuart Miller
# Last updated June 20, 2019
#############
library(tidyverse)
library(naniar)

#read in dataset
beer_data <- read_csv("Beers.csv", col_types = 
                        cols(
                          Name = col_character(),
                          Beer_ID = col_character(),
                          ABV = col_double(),
                          IBU = col_double(),
                          Brewery_id = col_character(),
                          Style = col_character(),
                          Ounces = col_factor()
                        ))

# Rename name column
colnames(beer_data)[colnames(beer_data) == "Name"] <- "Beer_name"

# Function uses regexes to scrape beer style
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

# Final output
beer_data <- beer_data %>%
              replace_with_na(replace = list(Style = c("", " "))) %>%
              rowwise() %>%
              mutate(ShortStyle = get_relevant_words(Style))

beer_data$ShortStyle <- as_factor(beer_data$ShortStyle)
  

