## load libraries
library(data.table)

## download file from website and store in "data.zip" file
## unzip file and read into table
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(URL, destfile="data.zip", method="curl")
data <- read.table(unzip("data.zip"), header= TRUE, na.strings="?", sep=";")

## subset data for desired focus dates and load into data.table for easier manipulation
focusdata <- subset(data, Date == '1/2/2007' | Date == '2/2/2007')
DT <- data.table(focusdata)

## create new column combining date and time 
## convert date and time into useable values and place these into new column
DT[, DateTime := paste(Date, Time)]
DT[, cleanDateTime := as.POSIXct(strptime(DT$DateTime, "%d/%m/%Y %H:%M:%S"))]

## plot3
png(filename = "plot3.png", width=480, height=480)
par(mfrow=c(1,1))
plot(DT$cleanDateTime, DT$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(DT$cleanDateTime, DT$Sub_metering_1, type="l", col = "black")
lines(DT$cleanDateTime, DT$Sub_metering_2, type="l", col = "red")
lines(DT$cleanDateTime, DT$Sub_metering_3, type="l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()