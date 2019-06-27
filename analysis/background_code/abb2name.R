###########
# Function for converting US state abbrevations to full names.
# Adapted from ligyxy:
# https://gist.github.com/ligyxy/acc1410041fe2938a2f5
###########

abb2state <- function(name, convert = F, strict = F){
  data(state)
  # state data doesn't include DC
  state = list()
  state[['name']] = c(state.name,"District Of Columbia")
  state[['abb']] = c(state.abb,"DC")
  
  if(convert) state[c(1,2)] = state[c(2,1)]
  
  single.a2s <- function(s){
    if(strict){
      is.in = tolower(state[['abb']]) %in% tolower(s)
      ifelse(any(is.in), state[['name']][is.in], NA)
    }else{
      # To check if input is in state full name or abb
      is.in = rapply(state, function(x) tolower(x) %in% tolower(s), how="list")
      tolower(state[['name']][is.in[[ifelse(any(is.in[['name']]), 'name', 'abb')]]])
    }
  }
  sapply(name, single.a2s)
}