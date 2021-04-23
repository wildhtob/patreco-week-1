# Load Pacakges ####

library(readr)        # to import tabular data (e.g. csv)
library(dplyr)        # to manipulate (tabular) data
library(ggplot2)      # to visualize data
library(sf)           # handling spatial data

# Task 1: Import data ####

wildschwein = read_delim("./data/wildschwein_BE.csv", delim = ",")
str(wildschwein)

# Task 2: Explore Data ####

ggplot(wildschwein, aes(Long, Lat, colour = TierID)) +
  geom_point()

# Handling spatial data ####

wildschwein_sf <- st_as_sf(wildschwein, coords = c("Long", "Lat"), crs = 4326)

wildschwein_sf

# subset rows
wildschwein_sf[1:10,]
wildschwein_sf[wildschwein_sf$TierName == "Sabi",]

# subset colums
wildschwein_sf[,2:3]

# replace initial data frame

wildschwein <- st_as_sf(wildschwein, coords = c("Long", "Lat"), crs = 4326)
rm(wildschwein_sf)
