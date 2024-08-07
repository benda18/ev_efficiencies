library(dplyr)

rm(list=ls());cat('\f')

cars <- c("tesla model 3", "chevy bolt", "hyundai kona")

locs <- c("Durham", "Charlottesville", "Carowinds", 
          "Cincinnati", "Asheville", "Chicago", 
          "Miami")

metrics <- c("total time", "charging time", 
             "total miles", "depart battery pct", 
             "arrive battery pct")

# makeup list of O-D pairs----
ods  <- expand.grid("Durham", locs, 
                    stringsAsFactors = F)
ods  <- ods[ods$Var1 != ods$Var2,] %>%
  .[order(.$Var1, .$Var2),]

ods$Var3 <- NA

for(i in 1:nrow(ods)){
  temp1 <- ods$Var1[i] %>% as.character()
  temp2 <- ods$Var2[i] %>% as.character()
  
  temp3 <- c(temp1, temp2)[order(c(temp1, temp2))]
  ods$Var3[i] <- paste(temp3, collapse = " ")
}

ods <- ods[!duplicated(ods$Var3),]

ods <- as_tibble(ods[,c(1,2)])
ods$Var1 <- as.character(ods$Var1)
ods$Var2 <- as.character(ods$Var2)

ods$route_id <- paste("r", 1:nrow(ods), 
                     sep = "")

# make cw_cars----
cw_cars <- expand.grid(route_id = ods$route_id, 
                       car = cars, 
                       stringsAsFactors = F)

# update ods with cars

odscars     <- full_join(ods,cw_cars)
odscars$tid <- paste("t", 1:nrow(odscars), sep = "")
