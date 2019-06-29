library(tidyverse)
library(naniar)
library(maps)
library(pwr)
library(simputation)


nabular_data %>%
  group_by(Ounces) %>%
  summarize(count = n()) %>%
  ggplot(aes(x=Ounces, y=count)) +
  geom_col()

nabular_data %>%
  group_by(Ounces) %>%
  filter(Ounces == "12" | Ounces == "16") %>%
  summarize(prop_missing = prop_miss(IBU) * 100) %>%
  ggplot(aes(x=Ounces, y=prop_missing, fill = Ounces)) +
  geom_col() +
  labs(title="Proportion of Missing IBU by Ounces",
       x="Ounces per Bottle",
       y="% Missing IBU")

#missingness by style
nabular_data %>%
  group_by(ShortStyle) %>%
  summarize(perc_miss_IBU = prop_miss(IBU) * 100,
            num_miss_IBU = n_miss(IBU)) %>%
  filter(num_miss_IBU > 15) %>%
  ggplot(aes(x=reorder(ShortStyle, desc(perc_miss_IBU)), y=perc_miss_IBU)) +
  geom_col() +
  labs(title="Missingness of IBU by Beer Style", x = "Beer Style", y = "% Missing IBU")

# missingness by state
missing.by.state <- merged_data %>% 
  group_by(region) %>% 
  summarise(ABV_missing=prop_miss(ABV) * 100,
            IBU_missing=prop_miss(IBU) * 100)

states <- map_data("state")
map.df <- merge(states, missing.by.state, by="region", all.x=T)
map.df <- map.df[order(map.df$order),]

ggplot(map.df, aes(x=long,y=lat,group=group, fill=IBU_missing))+
  geom_polygon()+
  geom_path()+ 
  scale_fill_gradientn(colours=rev(heat.colors(10)),na.value="grey90")+
  coord_map() +
  labs(title = 'Percent Missing IBU by State')

# most common type of beer brewed by state
beercount.state <- merged_data %>%
  group_by(region,
           ShortStyle) %>%
  count() %>%
  arrange(region,
          desc(n))

popularity <- beercount.state %>%
  group_by(region) %>%
  summarize(
    Beer = first(ShortStyle))

states <- map_data("state")
map.df <- merge(states, popularity, by="region", all.x=T)
map.df <- map.df[order(map.df$order),]

ggplot(map.df, aes(x=long,y=lat,group=group, fill=Beer))+
  geom_polygon()+
  geom_path()+ 
  coord_map() +
  labs(title = 'Most Common Type of Beer in Each State')
  


# ale by state
ale.by.state <- merged_data %>%
  group_by(region) %>%
  filter(ShortStyle == "Ale") %>%
  count()

beers.per.state <- merged_data %>%
  group_by(region) %>%
  summarize(number_of_beers = length(Beer_ID))

merged_alecount <- merge(ale.by.state, beers.per.state, by="region", all=FALSE)
merged_alecount <- merged_alecount %>%
  mutate(perc_ale = (n / number_of_beers) * 100)

states <- map_data("state")
map.df <- merge(states, merged_alecount, by="region", all.x=T)
map.df <- map.df[order(map.df$order),]

ggplot(map.df, aes(x=long,y=lat,group=group, fill=perc_ale))+
  geom_polygon()+
  geom_path()+ 
  scale_fill_gradientn(colours=rev(heat.colors(10)),na.value="grey90") +
  coord_map() +
  labs(title = '% Ale By State')
  
# style by ounce
merged_data %>%
  filter(Ounces == 16 | Ounces == 12) %>%
  group_by(ShortStyle,
           Ounces) %>%
  summarize(total = length(ShortStyle)) %>%
  ggplot(aes(x=Ounces, y=total, fill=ShortStyle)) +
  geom_col() +
  labs(title="Proportions of Styles in Ounces Group")

# Average ABV per style
merged_data %>%
  filter(Ounces == 16 | Ounces == 12) %>%
  group_by(ShortStyle) %>%
  summarize(meanABV = mean(ABV, na.rm=TRUE)) %>%
  filter(meanABV > 0.065) %>%
  ggplot(aes(x=reorder(ShortStyle, -meanABV), y=meanABV)) +
  geom_col() +
  labs(title = "Mean ABV by Style", x = "Style", y = "Mean ABV")

# Average ABV by Ounces
merged_data %>%
  filter(Ounces == 16 | Ounces == 12) %>%
  group_by(Ounces) %>%
  summarize(meanABV = mean(ABV, na.rm=TRUE)) %>%
  ggplot(aes(x=Ounces, y=meanABV, fill=Ounces)) +
  geom_col() +
  labs(title = "Mean ABV Between Ounces", x = "Ounces", y= "Mean ABV")

#density estimator of ABV faceted by Ounces
merged_data %>%
  filter(Ounces == 16 | Ounces == 12) %>%
  group_by(Ounces) %>%
  ggplot(aes(ABV, fill = Ounces)) + 
  geom_density() +
  facet_wrap(~Ounces) +
  labs(title = "Distribution of ABV faceted by Ounces", y = "Density")

#t-tests for comparison of ABV between 12 Ounce sample and 16 Ounce sample
merged_nomissingABV <- merged_data %>%
  filter(!is.na(ABV),
         Ounces == 12 | Ounces ==16)

paired_list <- merged_nomissingABV %>%
  group_split(Ounces)

paired_ABVdataframe <- merge(paired_list[[1]], paired_list[[2]], by="Beer_name", all=FALSE)

paired_ABVdataframe <- paired_ABVdataframe %>%
  mutate(diff_ABV = ABV.x - ABV.y)

t.test(paired_ABVdataframe$diff_ABV, mu=0)


# ABV and Missingness of IBU
merged_data %>%
  bind_shadow() %>%
  ggplot(aes(x = ABV,
             color = IBU_NA)) +
  geom_density()

# IBU by state
ggplot(map.df, aes(x=long,y=lat,group=group))+
  geom_polygon(aes(fill=MedianIBU))+
  geom_path()+ 
  scale_fill_gradientn(colours=rev(heat.colors(10)),na.value="grey90")+
  coord_map()+
  labs(title = 'Median IBU by State')

# ABV by State
ggplot(map.df, aes(x=long,y=lat,group=group))+
  geom_polygon(aes(fill=MedianABV))+
  geom_path()+ 
  scale_fill_gradientn(colours=rev(heat.colors(10)),na.value="grey90")+
  coord_map()+
  labs(title = 'Median ABV by State')

# need to tentatively drop values because simputation finds them problematic
# for some mysterious reason
imputed_data <- merged_data %>%
  bind_shadow(only_miss=TRUE) %>%
  filter(!is.na(ShortStyle),
         ShortStyle != "Cider",
         ShortStyle != "Mead",
         ShortStyle != "Rauchbier",
         ShortStyle != "Kristalweizen",
         ShortStyle != "Shandy",
         ShortStyle != "Liquor",
         ShortStyle != "Braggot",
         ShortStyle != "Alcohol") %>%
  add_label_shadow() %>%
  impute_lm(IBU ~ CensusDivision + ShortStyle)


# evaluating imputation; scale and location are great, but probably not enough variation
imputed_data %>% 
  ggplot(aes(x=IBU_NA, y=IBU)) + geom_boxplot()

imputed_data %>%
  ggplot(aes(x=IBU, y=ABV, color = IBU_NA)) + geom_point()

imputed_data %>%
  ggplot(aes(x=IBU, y=ABV, fill=IBU_NA)) + geom_histogram()

# linear model; all yield similar results
model1 <- lm(data=imputed_data, ABV ~ IBU + ShortStyle)
model2 <- lm(data=imputed_data, ABV ~ IBU)
model3 <- lm(data=merged_data, ABV ~ IBU)

summary(model1)
summary(model2)
summary(model3)

merged_data %>%
  remove_missing(na.rm=TRUE) %>%
  ggplot(aes(x=IBU, y=ABV)) +
  geom_point(alpha=0.1) +
  geom_smooth(method="lm") + 
  labs(title="ABV vs IBU")