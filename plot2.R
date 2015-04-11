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

## plot2
par(mfrow=c(1,1))
plot(DT$cleanDateTime, DT$Global_active_power, type="n", ylab="Global Active Power (kilowatts)", xlab="")
lines(DT$cleanDateTime, DT$Global_active_power, type="l")
dev.copy(png, file="plot2.png")
dev.off()