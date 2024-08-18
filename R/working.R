library(dplyr)
library(ggplot2)
library(renv)

renv::status()
renv::snapshot()


rm(list=ls());cat('\f')

carowinds.ice.rthrs <- 4+46/60


cars <- c("tesla model 3", "chevy bolt", "hyundai kona", 
          "volkswagen id.4")

locs <- c("Durham", "Charlottesville", "Carowinds", 
          "Hildredth Ave, Cincinnati", "Asheville", "Chicago", 
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

odscars[grepl("volkswagen", odscars$car) & 
          odscars$Var2 == "Carowinds",]$t_hrs <- 6+57/60
odscars[grepl("volkswagen", odscars$car) & 
          odscars$Var2 == "Carowinds",]$chrg_hrs <- 1+15/60
odscars[grepl("volkswagen", odscars$car) & 
          odscars$Var2 == "Carowinds",]$t_miles <- 328


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

odscars[grepl("volkswagen", odscars$car) & 
          odscars$Var2 == "Charlottesville",]$t_hrs <- 9+6/60
odscars[grepl("volkswagen", odscars$car) & 
          odscars$Var2 == "Charlottesville",]$chrg_hrs <- 1+59/60
odscars[grepl("volkswagen", odscars$car) & 
          odscars$Var2 == "Charlottesville",]$t_miles <- 379

# asheville
odscars[grepl("chevy", odscars$car) & 
          odscars$Var2 == "Asheville",]$t_hrs <- 9+43/60
odscars[grepl("chevy", odscars$car) & 
          odscars$Var2 == "Asheville",]$chrg_hrs <- 2+37/60
odscars[grepl("chevy", odscars$car) & 
          odscars$Var2 == "Asheville",]$t_miles <- 454

odscars[grepl("tesla", odscars$car) & 
          odscars$Var2 == "Asheville",]$t_hrs <- 8+28/60
odscars[grepl("tesla", odscars$car) & 
          odscars$Var2 == "Asheville",]$chrg_hrs <- 1+8/60
odscars[grepl("tesla", odscars$car) & 
          odscars$Var2 == "Asheville",]$t_miles <- 453

odscars[grepl("hyundai", odscars$car) & 
          odscars$Var2 == "Asheville",]$t_hrs <- 9+8/60
odscars[grepl("hyundai", odscars$car) & 
          odscars$Var2 == "Asheville",]$chrg_hrs <- 1+43/60
odscars[grepl("hyundai", odscars$car) & 
          odscars$Var2 == "Asheville",]$t_miles <- 458

odscars[grepl("volkswagen", odscars$car) & 
          odscars$Var2 == "Asheville",]$t_hrs <- 9+38/60
odscars[grepl("volkswagen", odscars$car) & 
          odscars$Var2 == "Asheville",]$chrg_hrs <- 2+7/60
odscars[grepl("volkswagen", odscars$car) & 
          odscars$Var2 == "Asheville",]$t_miles <- 454

ggplot(data = odscars, 
       aes(x = t_hrs, y = chrg_hrs)) + 
  geom_smooth(method = "lm", se = F) +
  geom_point()

ggplot(data = odscars, 
       aes(x = t_miles, y = chrg_hrs, 
           color = car)) + 
  geom_smooth(method = "lm", se = F) +
  geom_point()

odscars %>%
  group_by(car) %>%
  summarise(mpCh = sum(t_miles, 
                       na.rm = T) / 
              sum(chrg_hrs, na.rm = T))

# chevy carowinds scenarios----

cc <- function(max_spd    = NA, 
               max_soc    = NA, 
               total_hrs  = NA, 
               charge_hrs = NA,
               total_usd  = NA, 
               mpkwh      = NA, 
               miles      = NA, 
               car = "chevy_bolt"){
  
  data.frame(max.spd = max_spd, 
             max.soc = max_soc, 
             t.hrs = total_hrs, 
             chrg.hrs = charge_hrs,
             drive.hrs = total_hrs - charge_hrs,
             t.usd = total_usd, 
             mpkWh = mpkwh, 
             miles = miles, 
             car = car)  
}

cc.params <- expand.grid(maxMPH = c(seq(45,75,by=10)), 
                         maxCHRG = c(50,60))

spd_time50 <- as_tibble(rbind(cc(75,50, 
                               6+54/60, 1+33/60, 49.8, 3.46, 322),
                            cc(70,50, 
                               6+56/60, 1+30/60, 48.9, 3.56, 322),
                            cc(65,50, 
                               6+57/60, 1+26/60, 36.5, 3.68, 322),
                            cc(60,50, 
                               7+9/60, 1+19/60, 33.4, 3.88, 317),
                            cc(55,50, 
                               7+30/60, 1+14/60, 28.7, 4.07, 316),
                            cc(50,50, 
                               7+57/60, 1+9/60, 27.1, 4.26, 318),
                            cc(45,50, 
                               8+37/60, 1+6/60, 44.2, 4.43, 316)))

spd_time60 <- as_tibble(rbind(cc(75,60, 
                                 6+44/60, 1+35/60, 57.5, 3.42, 320),
                              cc(70,60, 
                                 6+47/60, 1+33/60, 59.3, 3.51, 319),
                              cc(65,60, 
                                 6+57/60, 1+28/60, 57.4, 3.67, 319),
                              cc(60,60, 
                                 7+18/60, 1+24/60, 30.6, 3.85, 326),
                              cc(55,60, 
                                 7+23/60, 1+15/60, 50.8, 4.06, 316),
                              cc(50,60, 
                                 8+2/60, 1+13/60, 51.7, 4.23, 323),
                              cc(45,60, 
                                 8+39/60, 1+10/60, 50.4, 4.39, 3.23)))

spd_time80 <- as_tibble(rbind(cc(75,80, 
                                 6+38/60, 1+45/60, 34.9, 3.43, 313),
                              cc(70,80, 
                                 6+42/60, 1+42/60, 34.3, 3.51, 313),
                              cc(65,80, 
                                 6+50/60, 1+36/60, 32.5, 3.67, 313),
                              cc(60,80, 
                                 7+3/60, 1+28/60, 33.6, 3.85, 314),
                              cc(55,80, 
                                 7+21/60, 1+21/60, 31.5, 4.06, 314),
                              cc(50,80, 
                                 7+48/60, 1+16/60, 29.7, 4.23, 313),
                              cc(45,80, 
                                 8+23/60, 1+11/60, 25.6, 4.39, 312)))

spd_time <- rbind(spd_time50, spd_time60, spd_time80)


ggplot() +
  geom_area(data = spd_time[spd_time$max.spd >= 60,], 
            aes(y = t.hrs, 
                x = max.spd,
                #fill = "Trip Time (hrs)", 
                color = "Trip Time (hrs)"),
            linewidth = 1.1, 
            alpha = 0.2) + 
  geom_point(data = spd_time[spd_time$max.spd >= 60,], 
             aes(y = t.hrs, 
                 x = max.spd,
                 #fill = "Trip Time (hrs)", 
                 color = "Trip Time (hrs)"),
             size = 4) +
  geom_line(data = spd_time[spd_time$max.spd >= 60,], linewidth = 1.1, 
            aes(y = chrg.hrs, 
                x = max.spd, 
                color = "Charging Time (hrs)")) +
  geom_point(data = spd_time[spd_time$max.spd >= 60,], size = 4,
             aes(y = chrg.hrs, 
                 x = max.spd, 
                 color = "Charging Time (hrs)")) +
  scale_y_continuous(breaks = seq(0,100,by=1), 
                     name = "Time (hrs)") +
  scale_x_continuous(name = "Speed (MPH)", 
                     breaks = seq(0,100,by=5))+
  scale_color_discrete(name = "Legend")+
  theme(legend.position = "right", 
        legend.direction = "vertical")+
  labs(title = "Chevy Bolt Speed VS Time", 
       subtitle = "Carowinds Trip")


ggplot() + 
  geom_path(data = spd_time[spd_time$max.spd >= 60,], size = 1.2,
            aes(x = drive.hrs, y = t.usd, 
                color = factor(max.soc), 
                group = max.soc)) +
  geom_point(data = spd_time[spd_time$max.spd >= 60,], 
             aes(x = drive.hrs, y = t.usd, 
                 color = factor(max.soc)), 
             size = 10) +
  geom_text(data = spd_time[spd_time$max.spd >= 60,], 
            aes(x = drive.hrs, y = t.usd, 
                label = max.spd)) +
  scale_color_discrete()

ggplot(data = spd_time[spd_time$max.spd >= 60,], 
       aes(x = max.spd, y = drive.hrs, 
           color = factor(max.soc))) + 
  geom_line() +
  geom_point(aes(size = chrg.hrs)) +
  #scale_size_area() +
  scale_y_continuous(breaks = seq(0,100,by=0.5), 
                     name = "Time (hrs)") +
  scale_x_continuous(name = "Speed (MPH)", 
                     breaks = seq(0,100,by=5))

ggplot(data = spd_time[spd_time$max.spd >= 60,], 
       aes(x = max.spd, y = chrg.hrs/drive.hrs, 
           color = factor(max.soc))) + 
  geom_line() +
  geom_point(aes(size = drive.hrs)) +
  #scale_size_area() +
  scale_y_continuous(#breaks = seq(0,100,by=0.5), 
                     name = "Charge Time:Drive Time") +
  scale_x_continuous(name = "Speed (MPH)", 
                     breaks = seq(0,100,by=5))


ggplot(data = spd_time[spd_time$max.spd >= 60,], 
       aes(x = max.spd, 
           y = t.hrs/carowinds.ice.rthrs, 
           color = factor(max.soc))) + 
  geom_line() +
  geom_point(aes(size = drive.hrs)) +
  # scale_x_log10()+
  # scale_y_log10()+
  theme(legend.position = "right", 
        legend.direction = "vertical")


spd_time[spd_time$t.hrs == min(spd_time$t.hrs),]


ggplot(data = spd_time, 
       aes(x = drive.hrs, y = t.usd)) + 
  geom_point(aes(color = factor(max.soc)), 
             size = 4)+
  geom_smooth(method = "lm")

ggplot(data = spd_time, 
       aes(x = chrg.hrs, y = t.usd)) + 
  geom_point(aes(color = factor(max.soc)), 
             size = 4)+
  geom_smooth(method = "lm")
