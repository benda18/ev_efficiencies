library(renv)
library(dplyr)
library(osrm)  # open source routing machine
library(remotes)
library(censusxy)

# install.packages("remotes")
# remotes::install_github("chris-prener/censusxy")

renv::status()
renv::snapshot()

rm(list=ls())


?osrm::osrmRoute()
