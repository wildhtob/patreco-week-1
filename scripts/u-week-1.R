# Load Pacakges ####

library(readr)        # to import tabular data (e.g. csv)
library(dplyr)        # to manipulate (tabular) data
library(ggplot2)      # to visualize data

# Task 1: Import data ####

wildschwein = read_delim("./data/wildschwein_BE.csv", delim = ",")
str(wildschwein)

# Task 2: Explore Data ####

ggplot(wildschwein, aes(Long, Lat, colour = TierID)) +
  geom_point()
