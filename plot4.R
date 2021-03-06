###########################################################################################
# Coursera Exploratory Data Analysis Week 1 Course Project
# Author: Sandeep Agarwal
# Date: Jan 6, 2017
#
# plot4.R File Description:
#
# This script will download the data from below URL, unzip it, and create plot as requested
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
###########################################################################################

# Clean up workspace
rm(list=ls())

# Set working directory to existing directory
setwd("/DataScience/R/c4project")

# Download the zip file if it doesn't exist already
filename <- "dataset.zip"
if (!file.exists(filename)){
     fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
     download.file(fileurl, filename, method="curl")
}  

# unzip the zip file in current working directory if not done so already
if (!file.exists("household_power_consumption.txt")) {unzip(filename)}

# Read the entire dataset
all_data <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", stringsAsFactors=FALSE)

# check the data type of variables
str(all_data)

# change the "Date" variable from character string to Date
all_data$Date <- as.Date(all_data$Date, format="%d/%m/%Y")

# Subsetting the data as per requirement
sub_data <- subset(all_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# remove the complete data set to free up memory
rm(all_data)

# Converting date and time variables to single datetime variable
datetime <- paste(as.Date(sub_data$Date), sub_data$Time)
sub_data$Datetime <- as.POSIXct(datetime)

# open the PNG device
png("plot4.png", width=480, height=480)

# setup 2x2 mfrow parameter and margins
par(mfrow=c(2,2), mar=c(5,5,3,2), oma=c(0,0,2,0))

# draw the 4 scatterplot diagrams using plot command and add the lines using annotation commands

plot(sub_data$Datetime, sub_data$Global_active_power, type="l", xlab="", ylab="Global Active Power")
plot(sub_data$Datetime, sub_data$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(sub_data$Datetime, sub_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(sub_data$Datetime, sub_data$Sub_metering_2, col="Red")
lines(sub_data$Datetime, sub_data$Sub_metering_3, col="Blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(sub_data$Datetime, sub_data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# close the device
dev.off()
# the  scatterplot is now ready in the plot4.png file and can be opened and checked
############# End of Script #############
