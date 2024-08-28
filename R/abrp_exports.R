library(dplyr)
library(ggplot2)
library(renv)
library(readr)
library(lubridate)
library(janitor)

renv::status()
renv::snapshot()

rm(list=ls());cat('\f')


a.trip <- "Waypoint	Arrival SoC	Depart SoC	Cost	Charge Card	Charge duration	Distance	Drive duration	Arrival	Departure
Point on map		95%				55 mi	53 min		10:16 PM
121 W. Elmsley Street, Greensboro [Electrify America]	68%	73%	$1		5 min	71 mi	1 h 3 min	11:08 PM	11:15 PM
Crossroads Center (Statesville, NC) [Electrify America]	39%	56%	$5		13 min	77 mi	1 h 7 min	12:18 AM	12:35 AM
Stuckey's (Old Fort, NC) [Electrify America]	18%	47%	$10		23 min	56 mi	53 min	1:42 AM	2:06 AM
5083 Jonathan Creek Rd, Waynesville [ChargePoint]	18%	58%	$9		32 min	94 mi	1 h 25 min	2:59 AM	3:32 AM
8445 Walbrook Drive, Knoxville [Electrify America]	18%	65%	$17		39 min	93 mi	1 h 18 min	4:57 AM	5:38 AM
1177 Sams Street, Cookeville [Electrify America]	18%	55%	$13		29 min	77 mi	1 h 5 min	5:57 AM	6:28 AM
Willowbrook Commons [Electrify America]	18%	80%	$26		58 min	130 mi	1 h 50 min	7:34 AM	8:34 AM
Pilot Travel Center 366 [EVgo]	18%	54%	$12		29 min	79 mi	1 h 6 min	10:25 AM	10:55 AM
6001 Poplar Ave, Memphis [Electrify America]	18%	47%	$10		23 min	64 mi	58 min	12:02 PM	12:28 PM
Walmart 91 Forrest City [Electrify America]	18%	75%	$20		51 min	115 mi	1 h 33 min	1:25 PM	2:18 PM
1003 N Museum Rd, Conway [ChargePoint]	18%	54%			29 min	70 mi	55 min	3:52 PM	4:22 PM
Walmart 66 - Clarksville, AR [Electrify America]	18%	90%	$26		1 h 13 min	83 mi	1 h 6 min	5:18 PM	6:33 PM
Cookson Hills - Sallisaw [EvGateway]	48%	63%			14 min	87 mi	1 h 7 min	7:39 PM	7:55 PM
706 S Woody Guthrie St, Okemah [ChargePoint]	19%	49%			24 min	62 mi	50 min	9:02 PM	9:27 PM
2917 S Douglas Blvd, Midwest City [ChargePoint]	19%	54%	$0		28 min	75 mi	1 h 1 min	10:17 PM	10:48 PM
1401 N Airport Rd, Weatherford [ChargePoint]	18%	56%			30 min	77 mi	1 h 1 min	11:50 PM	24:23
Love's 253 - Erick, OK [Electrify America]	18%	80%	$22		57 min	108 mi	1 h 22 min	1:24 AM	2:22 AM
Pilot Travel Center 723 [EVgo]	20%	83%	$24		1 h	117 mi	1 h 32 min	3:44 AM	4:46 AM
Love's 262 (Tucumcari, NM) [Electrify America]	18%	51%	$12		26 min	57 mi	46 min	5:18 AM	5:49 AM
Love's Travel #285 (Santa Rosa, NM) [Electrify America]	18%	79%	$25		56 min	113 mi	1 h 30 min	6:35 AM	7:33 AM
EV Connect Paws & Plugs: EV Charging Stations & Dog Park by Rich Ford [EV Connect]	19%	64%	$16		38 min	86 mi	1 h 9 min	9:03 AM	9:42 AM
1854 Pinon Dr, Grants [ChargePoint]	18%	48%	$8		24 min	60 mi	49 min	10:51 AM	11:17 AM
Walmart 906 - Gallup, NM [Electrify America]	18%	79%	$22		57 min	126 mi	1 h 38 min	12:06 PM	1:05 PM
Flying J 612 [EVgo]	18%	53%	$13		28 min	58 mi	47 min	1:44 PM	2:13 PM
2601 E. Huntington. Rd., Flagstaff [Electrify America]	18%	66%	$17		41 min	97 mi	1 h 27 min	3:00 PM	3:44 PM
Prescott, AZ, United States	20%					0 m		5:11 PM	
"
a.trip <- gsub(" \\(\\+1\\)", "", a.trip)

b.trip <- readr::read_tsv(a.trip, 
                          col_types = c("c", "c", "c", 
                                        "c", "c", "c", "c", 
                                        "t", "t")) %>%
  clean_names()

b.trip$departure


b.trip$arrival_so_c <- b.trip$arrival_so_c %>% 
  gsub("%", "", .) %>% 
  as.numeric()
b.trip$depart_so_c <- b.trip$depart_so_c %>% 
  gsub("%", "", .) %>% 
  as.numeric()

b.trip <- mutate(b.trip, 
                 arrival_so_c = arrival_so_c / 100, 
                 depart_so_c  = depart_so_c  / 100)

b.trip$drive_duration
b.trip$charge_duration <- b.trip$charge_duration %>% as.period() %>% as.numeric()  

b.trip <- mutate(b.trip, 
                 charge_duration  = as.numeric(as.period(charge_duration))/60/60, 
                 drive_duration = as.numeric(as.period(drive_duration))/60/60)

b.trip$cost     <- as.numeric(gsub("\\$", "", b.trip$cost))
b.trip$distance <- as.numeric(gsub(" m.*$", "", b.trip$distance))

b.trip <- mutate(b.trip, 
                 soc_charged = depart_so_c - arrival_so_c)

b.trip$soc_used <- NA
for(i in 2:nrow(b.trip)){
  b.trip$soc_used[i] <- b.trip$depart_so_c[i-1] - b.trip$arrival_so_c[i]
}

# b.trip$seg_duration <- NA
# for(i in 2:nrow(b.trip)){
#   b.trip$seg_duration[i] <- b.trip$departure[i-1] - b.trip$arrival[i]
# }

ggplot(data = b.trip, 
       aes(y = arrival_so_c, x = depart_so_c, 
           size = charge_duration)) + 
  geom_point()+
  geom_smooth(method = "lm")+
  scale_y_continuous(#limits = c(0,1), 
                     breaks = seq(0,1, by = 0.1), 
                     labels = scales::percent) + 
  scale_x_continuous(#limits = c(0,1), 
                     breaks = seq(0,1, by = 0.1), 
                     labels = scales::percent)+
  scale_size_area()

ggplot(data = b.trip, 
       aes(x = cost, y = charge_duration)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_x_continuous(limits = c(0,NA)) +
  scale_y_continuous(limits = c(0,NA))

ggplot(data = b.trip, 
       aes(x = soc_charged, y = charge_duration)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_x_continuous(limits = c(0,NA)) +
  scale_y_continuous(limits = c(0,NA))

ggplot() + 
  geom_segment(data = b.trip, 
               aes(x = arrival_so_c, xend = depart_so_c, 
                   y = charge_duration, yend = charge_duration)) +
  scale_x_continuous(limits = c(0,NA)) +
  scale_y_continuous(limits = c(0,NA))

ggplot() + 
  geom_point(data = b.trip, 
             aes(x = distance, y = drive_duration))

plot(b.trip[,c(2,3,4,6,7,8,11,12)])

