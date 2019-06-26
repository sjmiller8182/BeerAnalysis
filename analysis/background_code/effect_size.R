###########
# Function for retrieving effect size for regression model
# Author: Kevin Thompson and Stuart Miller
# Last Updated June 25, 2019
###########


get_effect_size <- function(full_model, reduced_model) {
  full_rsquared <- summary(full_model)$r.squared
  reduced_rsquared <- summary(reduced_model)$r.squared
  effect_size <- compute_cohens_f2(full_rsquared, reduced_rsquared)
  return(effect_size)
}


compute_cohens_f2 <- function(full_rsq, reduc_rsq) {
  extra_rsq <- full_rsq - reduc_rsq
  return(extra_rsq/(1-full_rsq))
}