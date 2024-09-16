library(renv)
library(dplyr)
library(osrm)  # open source routing machine
library(remotes)
library(censusxy)
library(sf)
library(ggplot2)

# install("sf")
# install.packages("remotes")
# remotes::install_github("chris-prener/censusxy")

renv::status()
renv::snapshot()

rm(list=ls())

# functions----
km2mi <- function(km){
  km * 0.621371
}


# vars----
addr.start <- "100 hargett st, raleigh, nc"
addr.end   <- "100 main st, durham, nc"


# census geocode----
xy.start <- cxy_oneline(address = addr.start)[c("coordinates.x","coordinates.y")]
xy.end   <- cxy_oneline(address = addr.end)[c("coordinates.x","coordinates.y")]



car.route <- osrmRoute(src = xy.start, 
                       dst = xy.end,
                       overview = F, # "simplified",
                       osrm.profile = "car")
bike.route <- osrmRoute(src = xy.start, 
                        dst = xy.end, 
                        overview = F, # "simplified",
                        osrm.profile = "bike")

# update units

try(car.route$dist_mi <- car.route$distance %>% km2mi())
try(car.route["dist_mi"] <- car.route["distance"] %>% km2mi()) 

try(car.route$dur_mins <- car.route$duration / 60)
try(car.route["dur_mins"] <- car.route["duration"] / 60) 



str(car.route)

ggplot() +
  geom_sf(data = bike.route, 
          aes(color = "bike", 
              linewidth = distance)) + 
  geom_sf(data = car.route, 
          aes(color = "car", 
              linewidth = distance))


