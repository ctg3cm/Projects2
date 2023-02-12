# Tiange Chang, Yi Feng, Shuhan Li, Yixiao Wang

library(tidyverse)
library(extraDistr)
library(ggplot2)

capacity <- 36 + 15
maxbus <- 46
n <- 10000

# At any given time, 25–35 buses were in active operation peak hour

# import data
peak <- read_excel("Desktop/peak.xlsx")

# Processing data
peak[,2] <- round(peak[,2], 0)
peak[,3] <- round(peak[,3], 0)
peak[,4] <- round(peak[,4], 0)
peak[,5] <- round(peak[,5], 0)
peak <- as.data.frame(peak)

# Hourly demand for transit followed a normal distribution with a standard deviation close to 20 per cent of the mean.

# All simulation passenger # are shown in the table "df" simulating # of passenger taking on bus on go round

df <- as.data.frame(mean(rnorm(n = 10000, mean = peak[1, 2], 
                               sd = peak[1, 2] * 0.2)))
for (i in 1:21){
  df[i, 1] = mean(rnorm(n = 1000, mean = peak[i, 2], sd = peak[i, 2] * 0.2))
}

df[, 1] <- round(df[, 1], 0)

# Simulating # of passenger taking off bus on go round
for (i in 1:21){
  df[i, 2] = mean(rnorm(n = 1000, mean = peak[i, 3], sd = peak[i, 3] * 0.2))
}

df[,2]<-round(df[,2],0)

#simulating # of passenger getting on bus on back round
for (i in 1:21){
  df[i,3]=mean(rnorm(n=1000,mean=peak[i,4],sd=peak[i,4]*0.2))
}

df[, 3] <- round(df[, 3], 0)

# Simulating # of passenger taking off bus on back round
for (i in 1:21){
  df[i,4] = mean(rnorm(n = 1000, mean = peak[i, 5], sd = peak[i, 5] * 0.2))
}

df[, 4] <- round(df[, 4], 0)

colnames(df) <- c("go_takeon_sim", "go_takeoff_sim", 
                  "back_takeon_sim", "back_takeoff_sim")

# Import data for non peak time
nonpeak <- read_excel("Desktop/nonpeak.xlsx")
View(nonpeak)

nonpeak[, 2] <- round(nonpeak[, 2], 0)
nonpeak[, 3] <- round(nonpeak[, 3], 0)
nonpeak[, 4] <- round(nonpeak[, 4], 0)
nonpeak[, 5] <- round(nonpeak[, 5], 0)
nonpeak <- as.data.frame(nonpeak)

# simulating passenger # for non peak time shown in table "dfnon"

# simulating # of passenger taking on bus on go round
dfnon <- as.data.frame(mean(rnorm(n = 10000, mean = nonpeak[1, 2], 
                                  sd = nonpeak[1, 2] * 0.2)))
for (i in 1:21){
  dfnon[i, 1] = mean(rnorm(n = 1000, mean = nonpeak[i, 2], 
                           sd = nonpeak[i, 2] * 0.2))
}

dfnon[, 1] <- round(dfnon[, 1], 0)

# Simulating # of passenger taking off bus on go round
for (i in 1:21){
  dfnon[i, 2] = mean(rnorm(n = 1000, mean = nonpeak[i, 3], 
                           sd = nonpeak[i, 3] * 0.2))
}

dfnon[,2] <- round(dfnon[, 2], 0)

# Simulating # of passenger getting on bus on back round
for (i in 1:21){
  dfnon[i, 3] = mean(rnorm(n = 1000, mean = nonpeak[i, 4], 
                           sd = nonpeak[i, 4] * 0.2))
}

dfnon[, 3] <- round(dfnon[, 3], 0)

# Simulating # of passenger taking off bus on back round
for (i in 1:21){
  dfnon[i, 4] = mean(rnorm(n = 1000, mean = nonpeak[i, 5], 
                           sd = nonpeak[i, 5] * 0.2))
}

dfnon[, 4] <- round(dfnon[, 4], 0)

colnames(dfnon) <- c("go_takeon_sim", "go_takeoff_sim", 
                     "back_takeon_sim", "back_takeoff_sim")

# Export simulation data for calculating the passenger number on the bus in Excl
write.csv(dfnon, file = "Desktop/dfnon.csv", quote = F)
write.csv(df, file = "Desktop/df.csv", quote = F)

# Import simulation data
peak_sim <- read_csv("Desktop/peak.csv")
nonpeak_sim <- read_csv("Desktop/nonpeak.csv")
station <- c(1:21)

################################################################################

# 1. Plot of # of passengers on the go-trip bus for going to next station at Peak Time
plot(station, peak_sim$`p#for_go`, type = "l",
     main = paste("Number of Passengers on the go-trip bus", "\n", 
                  "for going to next station at Peak Time"),
     xlab = "Station Number", 
     ylab = "Number of Passengers") + 
  abline(v = which(peak_sim$`p#for_go` == max(peak_sim$`p#for_go`)), 
         col = "red") + 
  text(12, 820, paste("Maximum Demand", max(peak_sim$`p#for_go`),
                      "\n", "Station Number:", 
                      which(peak_sim$`p#for_go` == max(peak_sim$`p#for_go`))))

# Max Demand
max(peak_sim$`p#for_go`)
# The maximum number of passengers taking the go-trip bus at peak time is 1207
# This appear on GPO station for going to Shivaji Vatika station
bus_go_peak <- max(peak_sim$`p#for_go`) / capacity
bus_go_peak # 23.66667
# 24 buses for go-trip at peak time

# 2. Plot of # of passengers on the back-trip bus for going to next station at Peak Time
plot(station, peak_sim$`p#for_back`, type = "l",
     main = paste("Number of Passengers on the back-trip bus", "\n", 
                  "for going to next station at Peak Time"),
     xlab = "Station Number",
     ylab = "Number of Passengers") + 
  abline(v = which(peak_sim$`p#for_back` == max(peak_sim$`p#for_back`)), 
         col = "red") + 
  text(14, 820, paste("Maximum Demand", max(peak_sim$`p#for_back`), 
                      "\n", "Station Number:", 
                      which(peak_sim$`p#for_back` == 
                              max(peak_sim$`p#for_back`))))

# Max Demand
max(peak_sim$`p#for_back`)
# The maximum number of passengers taking the back-trip bus at peak time is 1330
# This appear on  LIG station for going to Press Complex
bus_back_peak <- max(peak_sim$`p#for_back`) / capacity
bus_back_peak # 26

# 3. Plot of # of passengers on the go-trip bus for going to next station at NonPeak Time
plot(station, nonpeak_sim$`p#for_go`, type = "l",
     main = paste("Number of Passengers on the go-trip bus", "\n", 
                  "for going to next station at NonPeak Time"), 
     xlab = "Station Number",
     ylab = "Number of Passengers") + 
  abline(v = which(nonpeak_sim$`p#for_go` == max(nonpeak_sim$`p#for_go`)), 
         col = "red") + 
  text(12, 300, paste("Maximum Demand", max(nonpeak_sim$`p#for_go`),
                      "\n", "Station Number:", 
                      which(nonpeak_sim$`p#for_go` == 
                              max(nonpeak_sim$`p#for_go`))))

# Max Demand
max(nonpeak_sim$`p#for_go`)
# The maximum number of passengers taking the go-trip bus at Nonpeak time is 399
# This appear on Geeta Bhawan station for going to Palasiya station
bus_go_nonpeak <- max(nonpeak_sim$`p#for_go`) / capacity
bus_go_nonpeak # 8

# 4. Plot of # of passengers on the back-trip bus for going to next station at NonPeak Time
plot(station, nonpeak_sim$`p#for_back`, type = "l",
     main = paste("Number of Passengers on the back-trip bus", "\n", 
                  "for going to next station at NonPeak Time"),
     xlab = "Station ID", 
     ylab = "Number of Passengers") + 
  abline(v = which(nonpeak_sim$`p#for_back` == max(nonpeak_sim$`p#for_back`)), 
         col = "red") + 
  text(12, 300, paste("Maximum Demand", max(nonpeak_sim$`p#for_back`), 
                      "\n", "Station Number:", 
                      which(nonpeak_sim$`p#for_back` == 
                              max(nonpeak_sim$`p#for_back`))))

# Max Demand
max(nonpeak_sim$`p#for_back`)
# The maximum number of passengers taking the go-trip bus at Nonpeak time is 436
# This still appear on Geeta Bhawan station for going to Palasiya station
bus_back_nonpeak <- max(nonpeak_sim$`p#for_back`) / capacity
bus_back_nonpeak # 9

# Bus number, bn = bus number
bn <- data.frame(bus_go_peak, bus_back_peak, bus_go_nonpeak, bus_back_nonpeak)
bn <- round(bn) 
View(bn)

# Final result
sp <- 15 # average speed at peak time
snp <- 20 # average speed at nonpeak time
rl <- 11.57 # route length
pt <- rl * 60 / sp  # average time whole route in min at peak time 
npt <- rl * 60 / snp #  average time whole route in min at nonpeak time
pt # 46.28 mins
npt # 34.71 mins

# Frequency
hwpg <- 60 / 24 # headway peak time go 
hwpb <- 60 / 26 # headway peak time back 
hwng <- 60 / 8 # headway nonpeak time go 
hwnb <- 60 / 9 # headway nonpeak time back 
hwpg # 2.50 mins
hwpb # 2.31 mins
hwng # 7.50 mins
hwnb # 6.67 mins

# Total buses
pt / hwpg # 18.51 -> 19 peak time go 
pt / hwpb # 20.05 -> 21 peak time back
npt / hwng # 4.63 -> 5 nonpeak time go
npt / hwnb # 5.21 -> 6 nonpeak time back

# peak time total: 40
# nonpeak time total: 11

# Peak:

# By running the simulation, the optimal number of buses for peak time is 24 
# buses for 'go', and 26 buses for 'back', 50 buses in total. Then we assume 
# the average speed at peak time is 15 km/h, and the route length is 11.57 km. 
# Then we calculated the average time needed from the first stop to the last
# stop. It is 46.28 mins. Next, we calculated the frequency. It is 2.5 mins for
# peak time go, and 2.31 mins for peak time back. Finally, we divide the average
# time by the frequency to find out the total bus number. It is 19 for peak time 
# go, and 21 for peak time back. Total 40 buses.

# Nonpeak:

# By running the simulation, the optimal number of buses for nonpeak time is 8 
# buses for 'go', and 9 buses for 'back', 17 buses in total. Then we assume 
# the average speed at peak time is 20 km/h, and the route length is 11.57 km. 
# Then we calculated the average time needed from the first stop to the last
# stop. It is 34.71 mins. Next, we calculated the frequency. It is 7.5 mins for
# peak time go, and 6.67 mins for peak time back. Finally, we divide the average
# time by the frequency to find out the total bus number. It is 5 for peak time 
# go, and 6 for peak time back. Total 11 buses.
