library(ggplot2)
library(lubridate)
library(renv)
library(dplyr)

status()

rm(list=ls());cat("\f")
gc()

# vars----
dt_monday <- ymd_hms("2025-03-03 12:00:00 AM", tz = "America/New_York")

# setup----
dt_week.end <- dt_monday %m+% days(7) %m-% seconds(1)
cw_dow      <- data.frame(date = as_date(dt_monday) %m+% 
                            days(0:6))  |> as_tibble()
cw_dow$dow_f <- strftime(x = cw_dow$date, 
                         format = "%A",
                         tz = "America/New_York") 

cw_dow$dow_f <- factor(cw_dow$dow_f, 
                       #levels = .[order(.)][c(2,6,7,5,1,3,4)])
                       levels = unlist(strsplit("Monday Tuesday Wednesday Thursday Friday Saturday Sunday", " ")))


cw_dow$date_label_f <- strftime(x = cw_dow$date, 
                                format = "%B %d, %Y",
                                tz = "America/New_York") 

cw_dow$date_label_f <- factor(cw_dow$date_label_f, 
                              levels = unlist(strsplit("Monday Tuesday Wednesday Thursday Friday Saturday Sunday", " ")))

cw_dow <- cw_dow |> as_tibble()

# pricing----
evgo <- data.frame(start_hour = c(0, 4, 20, 10), 
                   end_hour   = c(4, 10, 24, 20),
                   period_name = c("super off-peak", rep("off-peak",2), "peak"),
                   price_per_kWh = c(0.33, rep(0.34,2), 0.41), 
                   location = "all", 
                   brand = "evgo")

evgo.full <- left_join(evgo, 
                       data.frame(brand = "evgo", 
                                  date = cw_dow$date))

ea <- data.frame(start_hour = 0, 
                 end_hour = 24, 
                 period_name = NA, 
                 price_per_kWh = c(0.48, 0.56)/1.25, 
                 location = c("all (not raleigh)", "raleigh"),
                 brand = "electrify america")

ea.full <- left_join(evgo, 
                     data.frame(brand = "ea", 
                                date = cw_dow$date))

tesla <- data.frame(start_hour = rep(c(0,4,8, 23),2), 
                    end_hour   = rep(c(4,8,23,24),2), 
                    period_name = rep(c("A", "B", "C", "A"),2), 
                    price_per_kWh = c(.23,.22,.40,.23), 
                    location = c(rep("durham",4), rep("rdu",4)), 
                    brand = "tesla")

tesla.full <- left_join(evgo, 
                        data.frame(brand = "tesla", 
                                   date = cw_dow$date))

full.full <- rbind(ea.full, evgo.full) %>%
  rbind(., tesla.full) %>% 
  as_tibble() 

full.full$dt_start <- force_tz(full.full$date, 
                               tzone = "America/New_York") %m+% 
  hours(full.full$start_hour)
full.full$dt_end <- force_tz(full.full$date, 
                             tzone = "America/New_York") %m+% 
  hours(full.full$end_hour)



# incentives----
lyft.incent <- data.frame(type = "busy_hours", 
                          dow_f = c(rep("Sunday",2), 
                                    "Monday","Thursday",
                                    rep("Friday",2),rep("Saturday",2)), 
                          start_hour = c(0,6,4,3,4,13,0,11),
                          start_minute = c(0,0,0,30,0,0,0,30),
                          end_hour = c(3,12,8,18,8,23,14,23), 
                          end_minute = c(0,0,0,0,30,59,30,59)) %>% as_tibble()

lyft.incent$dow_f <- factor(lyft.incent$dow_f, 
                            levels = unlist(strsplit("Monday Tuesday Wednesday Thursday Friday Saturday Sunday", " ")))



left_join(full.full[,c("date")], 
          cw_dow, by = "date") 

head(full.full)
# ggplot() + 
#   geom_segment(data = full.full)

lyft.incent_j <- left_join(lyft.incent, 
                           cw_dow, by = "dow_f") %>%
  mutate(.,
         start_dt = as_datetime(date) %m+% 
           hours(start_hour) %m+% 
           minutes(start_minute), 
         end_dt   = as_datetime(date) %m+% 
           hours(end_hour) %m+% 
           minutes(end_minute)) %>%
  .[order(.$start_dt),]

lyft.incent_j$end_dt   <- lyft.incent_j$end_dt %>% 
  force_tz(., "America/New_York")
lyft.incent_j$start_dt <- lyft.incent_j$start_dt %>% 
  force_tz(., "America/New_York")


ggplot() + 
  geom_segment(data = lyft.incent_j, 
               aes(x = start_dt, xend = end_dt, 
                   y = dow_f, yend = dow_f, 
                   color = factor(date)), 
               linewidth = 4)+
  geom_vline(aes(xintercept = Sys.time(), 
                 color = "Now"), 
             linetype = 2232)+
  theme(legend.position = "bottom", 
        legend.direction = "vertical", 
        axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))+
  labs(title = "lyft incentive schedule")+
  scale_x_datetime(date_breaks = "1 day", 
                   date_minor_breaks = "1 day") 

