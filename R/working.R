library(dplyr)

rm(list=ls());cat('\f')

cars <- c("tesla model 3", "chevy bolt", "hyundai kona")

locs <- c("Durham", "Charlottesville", "Carowinds", 
          "Cincinnati", "Asheville")

ods  <- expand.grid(locs,locs)
ods  <- ods[ods$Var1 != ods$Var2,] %>%
  .[order(.$Var1, .$Var2),]
