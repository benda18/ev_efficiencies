library(dplyr)
library(ggplot2)
library(lubridate)
library(renv)

renv::status()
renv::snapshot()

rm(list=ls());cat('\f')

# vars----
trip_mi  <- 200
refcon   <- 3.8
tripmi   <- 200
temptime <- Sys.time() %m+% hours(8)

# funs----
price2charge <- function(start.soc = 0.24, 
                         end.soc   = 0.8,
                         USDperKw  = 0.30,
                         battKw    = 63){
  net.soc <- end.soc-start.soc
  net.Kw  <- net.soc * battKw
  net.usd <- net.Kw * USDperKw
  return(net.usd)
}
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


getprice_evgo <- function(date_time){
  require(dplyr)
  temp.hr <- date_time %>% hour()
  temp.min <- date_time %>% minute()
  temp.min <- temp.min / 60
  
  temp.sec <- date_time %>% second()
  temp.sec <- temp.sec / 60 / 60
  
  temp.time <- temp.hr + 
    temp.min + 
    temp.sec
  
  if(nchar(temp.min*60)==1){
    temp.min <- paste("0", temp.min*60, sep = "")
  }else{
    temp.min <- as.character(temp.min*60)
  }
  
  price.out <- NA
  
  if(temp.time < 8){
    price.out <- 0.26
  }
  
  if(between(temp.time, 8, 10) | 
     between(temp.time, 19, 24)){
    price.out <- 0.30
  }
  
  if(between(temp.time, 10, 19)){
    price.out <- 0.34
  }
  # time
  x <- temp.time
  x.hour   <- x %/% 1
  x.ampm   <- ifelse(x > 11, "PM", "AM")
  x.hour   <- ifelse(x > 12, x - 12, x) %/% 1
  #x.minute <- ((x %% 1)*60) %/% 1
  #x.time <- paste(x.hour,":",x.minute," ", x.ampm, sep = "")
  x.time <- paste(x.hour, ":", 
                  temp.min, 
                  x.ampm,
                  sep = "")
  return(list(time = x.time, 
              price.per.Kw = price.out))
}

# analysis----
getprice_evgo(Sys.time())


evtrip(tripmi, refcon, 0.39)  # 20.53
evtrip(tripmi, refcon, 0.34)  # 17.89
evtrip(tripmi, refcon, 0.30)  # 15.79
evtrip(tripmi, refcon, 0.26)  # 13.68

evtrip(tripmi, refcon, 0.17)  # 8.95

gastrip(tripmi, 31, 3.5)  # 22.58



# fffffffff

miles.per.month <- 4500
refcon
Kw.per.month    <- miles.per.month / refcon
usd.per.month   <- 0.34 * Kw.per.month


# Bolt_energy_plusminus----

boltc <- function(soc_start,
                  soc_end,
                  t_hrs,
                  t_kwh){ 
  # functions
  require(dplyr)
  # convert soc to decimal if not already
  if(soc_start > 1){
    soc_start <- soc_start / 100
  }
  if(soc_end > 1){
    soc_end <- soc_end / 100
  }
  # magnitude correct hours
  if(t_hrs > 4) { t_hrs  <- t_hrs  / 60 }
  
  temp.df <- data.frame(soc.start = soc_start, 
                        soc.end   = soc_end, 
                        hrs.chrg  = t_hrs, 
                        kwh.chrg  = t_kwh) #%>%
  #mutate(., 
  #      kwh.per.hr = kwh.chrg / hrs.chrg )
  
  return(temp.df)
}



bolt.caro <- rbind(boltc(soc_start = 50, 
                         soc_end   = 78, 
                         t_hrs     = 34/60, 
                         t_kwh     = 17.7), 
                   boltc(soc_start = 21,
                         soc_end   = 85,
                         t_hrs     = 68/60,
                         t_kwh     = 39.6),
                   boltc(soc_start = 19,
                         soc_end   = 56,
                         t_hrs     = 35/60,
                         t_kwh     = 23.8), 
                   boltc(20,85,
                         69/60, 40.3), 
                   boltc(41,70, 
                         30/60, 18), 
                   boltc(21,60,
                         37/60,24.4), 
                   boltc(33,56,
                         25/60,14.6)) %>%
  mutate(., trip_name = "carowinds")
bolt.cincy <- rbind(boltc(48,71,34,14.1), 
                    boltc(18,85,71,42), 
                    boltc(16,74,56,36.4), 
                    boltc(18,76,57,36.6), 
                    boltc(24,67,40,27.1), 
                    boltc(18,73,53,34.7), 
                    boltc(18,85,69,42),
                    boltc(16,77,61,38.3),
                    boltc(31,45,23,9)) %>%
  mutate(., trip_name = "cincinnati")
bolt.wbeach <- rbind(boltc(18,61,36,26.6), 
                     boltc(20,79,56,37),
                     boltc(18,61,36,26.6), 
                     boltc(20,58,32,24.1), 
                     boltc(18,52,31,21.4), 
                     boltc(68,73,9,3.3), 
                     boltc(20,61,35,25.8), 
                     boltc(20,47,23,17.2), 
                     boltc(23,60,32,22.8)) %>%
  mutate(., 
         trip_name = "wrightsville beach")

bolt.ashe <- rbind(boltc(37,84, 50, 29.5), 
                   boltc(18,79,58,38.3), 
                   boltc(21,75,51,33.7), 
                   boltc(14, 56,37,26.9), 
                   boltc(18,79,58,38.2), 
                   boltc(21,75,51,33.8)) %>%
  mutate(., trip_name = "asheville")

bolt.all <- rbind(bolt.caro,
                  bolt.cincy, 
                  bolt.wbeach, 
                  bolt.ashe)


slice.prop <- 0.33



ggplot(data = bolt.all,
       aes(x = hrs.chrg,
           y = kwh.chrg)) +
  geom_point(size = 4,
             aes(color = soc.end-soc.start)) +
  geom_smooth(method = "auto",
              se = F)+
  scale_color_viridis_c(option = "C")+
  theme(legend.position = "bottom",
        legend.direction = "vertical")+
  coord_cartesian()



plot(bolt.all)

cor(bolt.all$soc.start, 
    bolt.all$hrs.chrg) # -0.56
cor(bolt.all$soc.end, 
    bolt.all$hrs.chrg) # +0.77
cor(bolt.all$soc.end, 
    bolt.all$kwh.chrg) # +0.66
cor(bolt.all$hrs.chrg, 
    bolt.all$kwh.chrg) # +0.96

ggplot(data = bolt.all, 
       aes(y = soc.start, 
           x = soc.end)) + 
  geom_point(aes(size = kwh.chrg, 
                 color = trip_name))+
  geom_smooth(se = F, 
              method = "auto")+
  theme(legend.position = "bottom", 
        legend.direction = "vertical")+
  coord_quickmap() +
  scale_x_continuous(limits = c(0,1)) +
  scale_y_continuous(limits = c(0,1))

bolt.all %>%
  group_by(soc.start, 
           soc.end) %>%
  summarise(n = n(), 
            #min.chrg.hrs = min(hrs.chrg),
            med.chrg.hrs = median(hrs.chrg),
            #max.chrg.hrs = max(hrs.chrg), 
            med.kwh.chrg = median(kwh.chrg)) 

ggplot() + 
  geom_point()+
  geom_col(data = bolt.all, 
           aes(x = soc.end, 
               y = soc.end-soc.start, 
               fill = trip_name), 
           position = "dodge", 
           color = "black")+
  theme(legend.position = "bottom")

ggplot() + 
  geom_segment(data = bolt.all,
               aes(x = soc.start, xend = soc.end, 
                   y = 0, yend = hrs.chrg*60))+
  scale_y_continuous(name = "mins charged", 
                     breaks = seq(0,1000,by = 5)) + 
  scale_x_continuous(name = "SoC", limits = c(0,1), 
                     breaks = seq(0,1,by=0.1), 
                     labels = scales::percent)+
  facet_grid()


# explore drive speeds----

bspd <- function(max.spd, 
                 kwh.used,  
                 t.hrs, origin, dest){
  data.frame(max_spd = max.spd, 
             kwh_used = kwh.used, 
             t_hrs = t.hrs, 
             origin = origin, 
             destination = dest)
}

x <- rbind(bspd(80, 230.1, 15+49/60, "Durham", "ATL"),
           bspd(74, 228.2, 15+54/60, "Durham", "ATL"),
           bspd(72, 225.3, 16+3/60, "Durham", "ATL"),
           bspd(70, 222.2, 16+8/60, "Durham", "ATL"), 
           bspd(68, 218, 16+15/60, "Durham", "ATL"), 
           bspd(66, 214.5, 16+18/60, "Durham", "ATL"),
           bspd(64, 210.2, 16+29/60, "Durham", "ATL"),
           bspd(84, 229.9, 15+59/60, "Durham", "ATL"),
           bspd(60, 201.2, 17+7/60, "Durham", "ATL"),
           bspd(62, 205.1, 16+54/60, "Durham", "ATL"),
           bspd(58, 197.1, 17+27/60, "Durham", "ATL"),
           bspd(56, 193.2, 17+49/60, "Durham", "ATL"),
           bspd(50, 181.5, 19+17/60, "Durham", "ATL"),
           bspd(93, 229.9, 15+59/60, "Durham", "ATL"))

ggplot(data = x, 
       aes(y = kwh_used, 
           x = t_hrs)) + 
  geom_point() +
  geom_smooth(method = "auto", 
              se = F) 

ggplot(data = x, 
       aes(x = max_spd, 
           y = t_hrs)) + 
  geom_point() +
  geom_smooth(method = "auto", 
              se = F) 

ggplot(data = x, 
       aes(x = max_spd, 
           y = kwh_used)) + 
  geom_point() +
  geom_smooth(method = "auto", 
              se = F) 
