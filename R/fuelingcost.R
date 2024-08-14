library(dplyr)
library(ggplot2)

library(renv)

renv::status()
renv::snapshot()

rm(list=ls());cat('\f')


evtrip <- function(trip_mi, 
                   mpKw = 3.7, 
                   USDperKw = 0.39){
  
}

gastrip <- function(trip_mi, 
                    mpg = 31, 
                    USDperGal = 3.49){
  
}