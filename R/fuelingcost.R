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

bolt.all <- rbind(bolt.caro,
                  bolt.cincy, 
                  bolt.wbeach)


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
