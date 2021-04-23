# Load Pacakges ####

library(readr)        # to import tabular data (e.g. csv)
library(dplyr)        # to manipulate (tabular) data
library(ggplot2)      # to visualize data
library(sf)           # handling spatial data
library(janitor)      # clean and consistent naming
library(terra)        # import raster data
library(tmap)         # thematic maps

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

# Task 3: Project data from WGS84 ####

# convert to CH1903+ LV95 (crs = 2056)

wildschwein <- st_transform(wildschwein, crs = 2056)

wildschwein

# Calculate Convex Hull ####

# group by animal id
wildschwein_grouped <- group_by(wildschwein, TierID)

# summarise grouped animals
wildschwein_smry <- summarise(wildschwein_grouped)

# generate minimal bounding geometry

mcp <- st_convex_hull(wildschwein_smry)

# Task 4 Plotting spatial objects ####

plot (mcp)

ggplot(mcp, aes (fill = TierID)) +
  coord_sf() +
  geom_sf(alpha = 0.6) +
  coord_sf(datum = 2056)

# Importing raster data ####

pk100_BE <- terra::rast("data/pk100_BE.tif")

pk100_BE

plot(pk100_BE)

plotRGB(pk100_BE)

# Task 5 Adding background map ####

tm_shape(pk100_BE) +
  tm_rgb() +
  tm_shape(mcp) +
  tm_fill("TierID", alpha = 0.7) +
  tm_borders(col = "red", lwd = 1.5) +
  tm_layout(legend.bg.color = "white")

# Task 6 Create interactive map ####

tmap_mode("view") +
  tm_shape(mcp) +
  tm_fill("TierID", alpha = 0.7) +
  tm_borders(col = "red", lwd = 1.5) +
  tm_layout(legend.bg.color = "white")

    
