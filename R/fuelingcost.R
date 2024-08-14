library(dplyr)
library(ggplot2)

library(renv)

renv::status()
renv::snapshot()

rm(list=ls());cat('\f')


trip_mi <- 200

evtrip <- function(trip_mi, 
                   mpKw = 3.7, 
                   USDperKw = 0.39){
  
  trip_Kw  <- trip_mi / mpKw
  trip_USD <- trip_Kw * USDperKw
  return(trip_USD)
}

gastrip <- function(trip_mi, 
                    mpg = 31, 
                    USDperGal = 3.49){
  trip_gal  <- trip_mi / mpg
  trip_USD  <- trip_gal * USDperGal
  return(trip_USD)
}

refcon <- 3.8
tripmi <- 200


evtrip(tripmi, refcon, 0.39)  # 21.08
evtrip(tripmi, refcon, 0.29)  # 15.68
evtrip(tripmi, refcon, (0.39+0.28)/2)  # 18.11

gastrip(200, 31, 3.5)


