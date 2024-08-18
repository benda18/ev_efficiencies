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


fun_1 <- function(x,y) {(x^x) / log(x)}

fun_1(x = 3, y = 2)

ggplot() + 
  geom_function(fun = fun_1)
