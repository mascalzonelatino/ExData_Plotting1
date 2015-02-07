all_data <- read.table("household_power_consumption.txt" , col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep=";", header=TRUE)

obs <- subset(all_data, grepl("^[1,2]/2/2007", Date)) # observation period data 

remove(all_data)

# Recommended approach to convert a factor into a numeric is to convert 
# the factor into a character vector (using as.character) and then convert 
# the character vector into a numeric vector using as.numeric 

obs$Global_active_power <- as.numeric(as.character(obs$Global_active_power))
obs$Sub_metering_1 <- as.numeric(as.character(obs$Sub_metering_1))
obs$Sub_metering_2 <- as.numeric(as.character(obs$Sub_metering_2))
obs$Sub_metering_3 <- as.numeric(as.character(obs$Sub_metering_3))

datetime<-as.POSIXct(paste(obs$Date,obs$Time), format="%d/%m/%Y %H:%M:%S")

png(filename = "plot3.png", width = 480, height = 480)

with(obs, plot(y=Sub_metering_1,x=datetime, type = "n",xlab ="", ylab="Energy sub metering"))
with(obs, lines(y=Sub_metering_1,x=datetime,col="black"))
with(obs, lines(y=Sub_metering_2,x=datetime,col="red"))
with(obs, lines(y=Sub_metering_3,x=datetime,col="blue"))
legend("topright",lty="solid",col = c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()

