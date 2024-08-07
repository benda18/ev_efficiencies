library(dplyr)
library(ggplot2)

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


# chevy data input----
odscars$t_hrs     <- NA
odscars$chrg_hrs  <- NA
odscars$t_miles   <- NA
odscars$start_pct <- .5
odscars$end_pct   <- .2
odscars$max_battpct <- .8

# carowinds
odscars[grepl("chevy", odscars$car) & 
          odscars$Var2 == "Carowinds",]$t_hrs <- 6+39/60
odscars[grepl("chevy", odscars$car) & 
          odscars$Var2 == "Carowinds",]$chrg_hrs <- 1+43/60
odscars[grepl("chevy", odscars$car) & 
          odscars$Var2 == "Carowinds",]$t_miles <- 316

odscars[grepl("tesla", odscars$car) & 
          odscars$Var2 == "Carowinds",]$t_hrs <- 5+56/60
odscars[grepl("tesla", odscars$car) & 
          odscars$Var2 == "Carowinds",]$chrg_hrs <- 46/60
odscars[grepl("tesla", odscars$car) & 
          odscars$Var2 == "Carowinds",]$t_miles <- 317

odscars[grepl("hyundai", odscars$car) & 
          odscars$Var2 == "Carowinds",]$t_hrs <- 6+19/60
odscars[grepl("hyundai", odscars$car) & 
          odscars$Var2 == "Carowinds",]$chrg_hrs <- 1+9/60
odscars[grepl("hyundai", odscars$car) & 
          odscars$Var2 == "Carowinds",]$t_miles <- 316

# charlottesville
odscars[grepl("chevy", odscars$car) & 
          odscars$Var2 == "Charlottesville",]$t_hrs <- 8+46/60
odscars[grepl("chevy", odscars$car) & 
          odscars$Var2 == "Charlottesville",]$chrg_hrs <- 2+7/60
odscars[grepl("chevy", odscars$car) & 
          odscars$Var2 == "Charlottesville",]$t_miles <- 373

odscars[grepl("tesla", odscars$car) & 
          odscars$Var2 == "Charlottesville",]$t_hrs <- 7+30/60
odscars[grepl("tesla", odscars$car) & 
          odscars$Var2 == "Charlottesville",]$chrg_hrs <- 45/60
odscars[grepl("tesla", odscars$car) & 
          odscars$Var2 == "Charlottesville",]$t_miles <- 351

odscars[grepl("hyundai", odscars$car) & 
          odscars$Var2 == "Charlottesville",]$t_hrs <- 8+31/60
odscars[grepl("hyundai", odscars$car) & 
          odscars$Var2 == "Charlottesville",]$chrg_hrs <- 1+23/60
odscars[grepl("hyundai", odscars$car) & 
          odscars$Var2 == "Charlottesville",]$t_miles <- 366


ggplot(data = odscars, 
       aes(x = t_hrs, y = chrg_hrs)) + 
  geom_smooth(method = "lm", se = F) +
  geom_point()

ggplot(data = odscars, 
       aes(x = t_miles, y = chrg_hrs, 
           color = car)) + 
  geom_smooth(method = "lm", se = F) +
  geom_point()
