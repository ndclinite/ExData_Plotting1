library(dplyr)

##assumes presence of household_power_consumption.txt in the working directory

data_set <- read.table( file = "household_power_consumption.txt",
				    header = TRUE,
				    sep = ";"
				)

filter_set <- filter(data_set, format(as.Date(Date, "%d/%m/%Y"), format = "%Y-%m-%d") %in% c("2007-02-01", "2007-02-02"))

rm(data_set)
gc()

png( filename = "plot1.png",
	width = 480, height = 480, units = "px"
    )
hist( as.numeric(as.character(filter_set$Global_active_power)),
	 main = "Global Active Power",
	 xlab = "Global Active Power (kilowatts)",
	 col = "red"
	)
dev.off()