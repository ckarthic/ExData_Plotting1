#Plot 4

library(readr)
library(dplyr)
library(tidyr)
library(lubridate)

#Assumption: the data file is household_power_consumption.txt is assumed to have been downloaded and saved to the Working Directory

# read entire dataset TODO: figure out how to read just the relevant rows between 2/1/2007 and 2/2/2007
data <- read_csv2("household_power_consumption.txt", col_types = "??n?nnnnn", na = "?")
#format the Date column
data <- transform(data, Date = as.Date(Date, format = "%d/%m/%Y"))
#filter rows between 2/1/2007 and 2/2/2007
reldata <- filter(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02") )


#create the plot and save it in the PNG file
png(file = "Plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))
with(reldata, { 
  plot(as.POSIXct(paste(Date, Time)), Global_active_power/1000, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
  
  with(reldata, plot(as.POSIXct(paste(Date, Time)), Voltage/1000, xlab = "datetime", ylab = "Voltage", type = "l"))
  
  plot(as.POSIXct(paste(Date, Time)), Sub_metering_1/1000, type = "l", xlab = "", ylab = "Energy sub metering" )
  lines(as.POSIXct(paste(Date, Time)), Sub_metering_2/1000, col = "red")
  lines(as.POSIXct(paste(Date, Time)), Sub_metering_3/1000, col = "blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

  with(reldata, plot(as.POSIXct(paste(Date, Time)), Global_reactive_power, xlab = "datetime", type = "l"))
})

dev.off()

