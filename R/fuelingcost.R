library(dplyr)
library(ggplot2)
library(lubridate)

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


getprice_evgo <- function(date_time)

evtrip(tripmi, refcon, 0.34)  # 17.89
evtrip(tripmi, refcon, 0.26)  # 13.68
evtrip(tripmi, refcon, (0.34+0.26)/2)  # 15.79

gastrip(200, 31, 3.5)  # 22.58


