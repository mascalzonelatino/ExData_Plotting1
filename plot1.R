all_data <- read.table("household_power_consumption.txt" , col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep=";", header=TRUE)

observation_period_data <- subset(all_data, grepl("^[1,2]/2/2007", Date))

remove(all_data)

# Recommended approach to convert a factor into a numeric is to convert 
# the factor into a character vector (using as.character) and then convert 
# the character vector into a numeric vector using as.numeric 

observation_period_data$Global_active_power <- as.numeric(as.character(observation_period_data$Global_active_power))

png(filename = "plot1.png", width = 480, height = 480)

hist(observation_period_data$Global_active_power, col = "red", main = paste("Global Active Power"), xlab = "Global Active Power (kilowatts)")

dev.off()

