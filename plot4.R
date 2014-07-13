# Exploratory Data Analysis Project 1
# Name: plot4.R
# 

# On Windows, you also have to download curl from http://curl.haxx.se/
library(RCurl)
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "exdata-data-household_power_consumption.zip", method="curl")
unzip("exdata-data-household_power_consumption.zip")
file <- "household_power_consumption.txt"

# read.table will execute faster if you provide nrows, colclasses and comment_char = ""
# elapsed time for the read.table statement is 78.5 seconds 
# on a win 7 / 32 bit / 4 GB / Intel core 2 duo P8600 (2.4 GHZ)
col_classes <- c("character","character", rep("numeric", 7))
household <- read.table(file, header = TRUE, 
                        sep=";", 
                        nrows=2100000,  # nrows is actually 2,075,259
                        na.strings="?", 
                        colClasses=col_classes, 
                        comment.char = "")
# We need data for two dates only: 2007-02-01 and 2007-02-02
household <- household[(household$Date == '1/2/2007' | household$Date == '2/2/2007'),]


png(file = "plot4.png", width = 480, height = 480)
par("mfrow"=c(2,2), "mfcol"=c(2,2))
with(household, plot(strptime(paste(household$Date,household$Time), format="%d/%m/%Y %H:%M:%S"), 
                     Global_active_power, type="l",
                     ylab="Global Active Power (kilowatts)", xlab=""))

with(household, plot(strptime(paste(household$Date,household$Time), format="%d/%m/%Y %H:%M:%S"), 
                     Sub_metering_1, type="l", 
                     xlab="", ylab="Energy sub metering"))

with(household, lines(strptime(paste(household$Date,household$Time), format="%d/%m/%Y %H:%M:%S"), 
               Sub_metering_2, col='red'))

with(household, lines(strptime(paste(household$Date,household$Time), format="%d/%m/%Y %H:%M:%S"), 
               Sub_metering_3, col='blue'))

legend(x = "topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lwd=1, lty=rep(1,3))

with(household, plot(strptime(paste(household$Date,household$Time), format="%d/%m/%Y %H:%M:%S"), Voltage, 
              type="l", 
              ylab="Voltage",
              xlab="datetime"))

with(household, plot(strptime(paste(household$Date,household$Time), format="%d/%m/%Y %H:%M:%S"), Global_reactive_power, 
              type="l", 
              ylab="Global_reactive_power",
              xlab="datetime"))

dev.off()