## Here is the global data extraction instructions clean up variables
rm(list = ls())
## load needed libraries
library(data.table)
library(dplyr)
## Read the file
df <- fread("household_power_consumption.txt", sep = ";", na.strings = "?")
## convert to date
df$Date <- as.Date(df$Date, "%d/%m/%Y")
## subsetting on the requested dates
df <- df %>% filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
## generate a new column containing both date and time and add it to the data
## frame
date.time <- strptime(paste(as.character(df$Date), df$Time), "%Y-%m-%d %H:%M:%S")
df <- cbind(df, date.time)
## clean up the variable date.time
rm(date.time)

## generate the graph as required
png("plot1.png", width = 480, height = 480)
hist(df$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",
    main = "Global Active Power")
dev.off()
