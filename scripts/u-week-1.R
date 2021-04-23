# Load Pacakges ####

library(readr)        # to import tabular data (e.g. csv)
library(dplyr)        # to manipulate (tabular) data
library(ggplot2)      # to visualize data

# Import data ####

wildschwein = read_delim("./data/wildschwein_BE.csv", delim = ",")
str(wildschwein)
