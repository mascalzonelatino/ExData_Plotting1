all_data <- read.table("household_power_consumption.txt" , col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep=";", header=TRUE)

obs <- subset(all_data, grepl("^[1,2]/2/2007", Date)) # observation period data 

remove(all_data)

# Recommended approach to convert a factor into a numeric is to convert 
# the factor into a character vector (using as.character) and then convert 
# the character vector into a numeric vector using as.numeric 

obs$Global_active_power <- as.numeric(as.character(obs$Global_active_power))

datetime<-as.POSIXct(paste(obs$Date,obs$Time), format="%d/%m/%Y %H:%M:%S")

png(filename = "plot2.png", width = 480, height = 480)

plot(datetime, obs$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()


