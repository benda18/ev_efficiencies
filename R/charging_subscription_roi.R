# charging price plan ROI


library(renv)
library(dplyr)
library(lubridate)
library(scales)
library(ggplot2)

renv::snapshot()
renv::status()

rm(list=ls());cat('\f')

t_monthly_cost <- function(per.month.sub = 12.99,
                           per.sess.usd = 0.00, 
                           per.kw.usd = 0.39, 
                           avg.soc.begin = 0.2, 
                           avg.soc.end = 0.7,
                           car.miles.per.day = 144,
                           car.batt.kw = 63.8, 
                           car.range.mi = 248){
  prc_mSubsc       <- per.month.sub
  prc_per_kW       <- per.kw.usd 
  prc_per_session  <- per.sess.usd
  avg_charge_range <- c(soc_begin = avg.soc.begin,
                        soc_end   = avg.soc.end)
  # car variables
  t_batt_kw        <- car.batt.kw
  t_range_mi       <- car.range.mi
  
  miles_per_day    <- car.miles.per.day
  
  # assumptions----
  n_days_in_month  <- 30
  mi_per_kwh       <- t_range_mi / t_batt_kw
  kw_per_day      <- miles_per_day / mi_per_kwh
  
  kW_per_session  <- unname((abs(diff(avg_charge_range)) * t_range_mi) / mi_per_kwh)
  n_sessions      <- length(seq(0, (miles_per_day * n_days_in_month), by = 200))
  
  prc_per_mile    <- prc_per_kW / mi_per_kwh
  
  out <- prc_mSubsc + # flat monthly rate
    (prc_per_session * n_sessions) + # per-session fees
    (n_sessions * kW_per_session * prc_per_kW)  # total kW price
  
  return(out)
}

args(t_monthly_cost)
t_monthly_cost()

# Analysis----

car_range     <- 241 #264 #248
car_battkwh   <- 61.4 #63.8
miles_per_day <- 144 #seq(0,160,by = 5)#144

mpd <- miles_per_day

# calcs
prices.out <- NULL
for(miles_per_day in mpd){
  tsla.sub.op <- t_monthly_cost(per.month.sub = 12.99, 
                                per.kw.usd = 0.20, 
                                per.sess.usd = 0, 
                                avg.soc.begin = 0.2, 
                                avg.soc.end = 0.7, 
                                car.miles.per.day = miles_per_day,
                                car.batt.kw = car_battkwh, 
                                car.range.mi = car_range)
  tsla.sub <- t_monthly_cost(per.month.sub = 12.99, 
                             per.kw.usd = 0.39, 
                             per.sess.usd = 0, 
                             avg.soc.begin = 0.2, 
                             avg.soc.end = 0.7, 
                             car.miles.per.day = miles_per_day,
                             car.batt.kw = car_battkwh, 
                             car.range.mi = car_range)
  tsla.no  <- t_monthly_cost(per.month.sub = 0, 
                             per.kw.usd = 0.39+0.11, 
                             per.sess.usd = 1, 
                             avg.soc.begin = 0.2, 
                             avg.soc.end = 0.7, 
                             car.miles.per.day = miles_per_day,
                             car.batt.kw = car_battkwh, 
                             car.range.mi = car_range)
  # EVGO
  evgo.pm.legacy.op <- t_monthly_cost(per.month.sub = 12.99, 
                                   per.kw.usd = 0.26, 
                                   per.sess.usd = 0, 
                                   avg.soc.begin = 0.2, 
                                   avg.soc.end = 0.7, 
                                   car.miles.per.day = miles_per_day,
                                   car.batt.kw = car_battkwh, 
                                   car.range.mi = car_range)
  evgo.pm.legacy <- t_monthly_cost(per.month.sub = 12.99, 
                                   per.kw.usd = 0.34, 
                                   per.sess.usd = 0, 
                                   avg.soc.begin = 0.2, 
                                   avg.soc.end = 0.7, 
                                   car.miles.per.day = miles_per_day,
                                   car.batt.kw = car_battkwh, 
                                   car.range.mi = car_range)
  evgo.uber.blue   <- t_monthly_cost(per.month.sub = 0, 
                                     per.kw.usd = 0.48, 
                                     per.sess.usd = 0, 
                                     avg.soc.begin = 0.2, avg.soc.end = 0.7, 
                                     car.miles.per.day =  miles_per_day, 
                                     car.batt.kw = car_battkwh, 
                                     car.range.mi = car_range)
  evgo.pm.sub    <- t_monthly_cost(per.month.sub = 12.99, 
                                   per.kw.usd = 0.42, 
                                   per.sess.usd = 0, 
                                   avg.soc.begin = 0.2, 
                                   avg.soc.end = 0.7, 
                                   car.miles.per.day = miles_per_day,
                                   car.batt.kw = car_battkwh, 
                                   car.range.mi = car_range)
  evgo.p.sub    <- t_monthly_cost(per.month.sub = 6.99, 
                                  per.kw.usd = 0.42, 
                                  per.sess.usd = 0, 
                                  avg.soc.begin = 0.2, 
                                  avg.soc.end = 0.7, 
                                  car.miles.per.day = miles_per_day,
                                  car.batt.kw = car_battkwh, 
                                  car.range.mi = car_range)
  evgo.no     <- t_monthly_cost(per.month.sub = 0, 
                                per.kw.usd = 0.5, 
                                per.sess.usd = 0.99, 
                                avg.soc.begin = 0.2, 
                                avg.soc.end = 0.7, 
                                car.miles.per.day = miles_per_day,
                                car.batt.kw = car_battkwh, 
                                car.range.mi = car_range)
  # EA
  ea.plus.sub      <- t_monthly_cost(per.month.sub = 7.99, 
                                     per.kw.usd = 0.36, 
                                     per.sess.usd = 1, 
                                     avg.soc.begin = 0.2, 
                                     avg.soc.end = 0.7, 
                                     car.miles.per.day = miles_per_day,
                                     car.batt.kw = car_battkwh, 
                                     car.range.mi = car_range)
  ea.lyft     <- t_monthly_cost(per.month.sub = 0, 
                                per.kw.usd = 0.48, 
                                per.sess.usd = 1, 
                                avg.soc.begin = 0.2, 
                                avg.soc.end = 0.7, 
                                car.miles.per.day = miles_per_day,
                                car.batt.kw = car_battkwh, 
                                car.range.mi = car_range)
  ea.no       <- t_monthly_cost(per.month.sub = 0, 
                                per.kw.usd = 0.48, 
                                per.sess.usd = 1, 
                                avg.soc.begin = 0.2, 
                                avg.soc.end = 0.7, 
                                car.miles.per.day = miles_per_day,
                                car.batt.kw = car_battkwh, 
                                car.range.mi = car_range)
  
  
  prices.out <- rbind(prices.out, 
                      data.frame(provider = c(rep("tesla", 3), 
                                              rep("evgo", 6), 
                                              rep("ea", 3)), 
                                 plan_name = c("offpeak", "plus", "no", 
                                               "offpeak", "plusMax_legacy", 
                                               "plusMax", 
                                               "plus", 
                                               "uber_lyft", 
                                               "no", 
                                               "plus", 
                                               "uber_lyft", 
                                               "no"), 
                                 mi_per_day = miles_per_day,
                                 car_kwpermi = car_range / car_battkwh,
                                 price_out = c(tsla.sub.op, 
                                               tsla.sub, tsla.no, 
                                               evgo.pm.legacy.op,
                                               evgo.pm.legacy, 
                                               evgo.pm.sub, 
                                               evgo.p.sub, 
                                               evgo.uber.blue, 
                                               evgo.no, 
                                               ea.plus.sub, 
                                               ea.lyft, 
                                               ea.no)))
  
  
}


prices.out <- as_tibble(prices.out)

slice_min(group_by(prices.out, mi_per_day, provider), 
          order_by = price_out, 
          n = 1) %>%
  ggplot(data = .,
         aes(x = mi_per_day, y = price_out)) + 
  geom_line(aes(group = provider)) +
  geom_point(#size = 1.2,
             aes(shape = provider, 
                 color = plan_name)) +
  #facet_grid(~provider) + 
  theme(legend.position = "bottom", 
        legend.direction = "vertical") 

prices.out %>%
ggplot(data = .,
       aes(x = mi_per_day, y = price_out)) + 
  #geom_line(aes(group = provider)) +
  geom_point(#size = 1.2,
    aes(shape = provider, 
        color = plan_name)) +
  geom_smooth(method = "auto", 
              se = F, 
              aes(color = provider))+
  #facet_grid(~provider) + 
  theme(legend.position = "bottom", 
        legend.direction = "vertical") 
