# charging price plan ROI


library(renv)
library(dplyr)
library(lubridate)
library(scales)

renv::snapshot()
renv::status()

rm(list=ls());cat('\f')


# variables----
# charging session variables
prc_mSubsc       <- 12.99
prc_per_kW       <- 0.39 
prc_per_session  <- 0.00
avg_charge_range <- c(soc_begin = 0.2,
                      soc_end   = 0.7)
# car variables
t_batt_kw        <- 63.8
t_range_mi       <- 248

miles_per_day    <- 144

# assumptions----
n_days_in_month  <- 30
mi_per_kwh       <- t_range_mi / t_batt_kw
kw_per_day      <- miles_per_day / mi_per_kwh

kW_per_session  <- unname((abs(diff(avg_charge_range)) * t_range_mi) / mi_per_kwh)
n_sessions      <- length(seq(0, (miles_per_day * n_days_in_month), by = 200))

prc_per_mile    <- prc_per_kW / mi_per_kwh

prc_mSubsc + # flat monthly rate
  (prc_per_session * n_sessions) + # per-session fees
  (n_sessions * kW_per_session * prc_per_kW)  # total kW price


# flat monthly rate
# price per mile
