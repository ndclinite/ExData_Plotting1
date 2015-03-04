library(dplyr)

##assumes presence of household_power_consumption.txt in the working directory

data_set <- read.table( file = "household_power_consumption.txt",
				    header = TRUE,
				    sep = ";"
				)

filter_set <- filter(data_set, format(as.Date(Date, "%d/%m/%Y"), format = "%Y-%m-%d") %in% c("2007-02-01", "2007-02-02"))

rm(data_set)
gc()

filter_set$DateTime <- strptime(paste(filter_set$Date, filter_set$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

png( filename = "plot4.png",
	width = 480, height = 480, units = "px"
	)
par(mfrow=c(2,2))
plot( x = filter_set$DateTime,
	 y = as.numeric(as.character(filter_set$Global_active_power)),
	 type = "l",
	 xlab = "",
	 ylab = "Global Active Power"
	)
plot( x = filter_set$DateTime,
	 y = as.numeric(as.character(filter_set$Voltage)),
	 type = "l",
	 xlab = "datetime",
	 ylab = "Voltage"
	)
plot( x = filter_set$DateTime,
	 y = as.numeric(as.character(filter_set$Sub_metering_1)),
	 type = "n",
	 xlab = "",
	 ylab = "Energy sub metering"
	)
lines(filter_set$DateTime, as.numeric(as.character(filter_set$Sub_metering_1)), col = "black")
lines(filter_set$DateTime, as.numeric(as.character(filter_set$Sub_metering_2)), col = "red")
lines(filter_set$DateTime, as.numeric(as.character(filter_set$Sub_metering_3)), col = "blue")
legend("topright", lwd = 1,col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n")
plot( x = filter_set$DateTime,
	 y = as.numeric(as.character(filter_set$Global_reactive_power)),
	 type = "l",
	 xlab = "datetime",
	 ylab = "Global_reactive_power",
	 ylim = c(0,0.5)
	)
dev.off()