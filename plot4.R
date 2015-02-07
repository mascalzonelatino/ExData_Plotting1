all_obs <- read.table("household_power_consumption.txt" , col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep=";", header=TRUE)

obs <- subset(all_obs, grepl("^[1,2]/2/2007", Date)) # observation period data 

remove(all_obs)

# Recommended approach to convert a factor into a numeric is to convert 
# the factor into a character vector (using as.character) and then convert 
# the character vector into a numeric vector using as.numeric 

obs$Global_active_power <- as.numeric(as.character(obs$Global_active_power))
obs$Sub_metering_1 <- as.numeric(as.character(obs$Sub_metering_1))
obs$Sub_metering_2 <- as.numeric(as.character(obs$Sub_metering_2))
obs$Sub_metering_3 <- as.numeric(as.character(obs$Sub_metering_3))
obs$Voltage <- as.numeric(as.character(obs$Voltage))
obs$Global_reactive_power <- as.numeric(as.character(obs$Global_reactive_power))

datetime<-as.POSIXct(paste(obs$Date,obs$Time), format="%d/%m/%Y %H:%M:%S")

png(filename = "plot4.png", width = 480, height = 480)

par(mfcol=c(2,2)) #2x2 subplots 

# first subplot 
with(obs, plot(y=Global_active_power,x=datetime, type = "n",xlab ="", ylab="Global Active Power"))
with(obs, lines(y=Global_active_power,x=datetime))

# second subplot 
with(obs, plot(y=Sub_metering_1,x=datetime, type = "n",xlab ="", ylab="Energy sub metering"))
with(obs, lines(y=Sub_metering_1,x=datetime,col="black"))
with(obs, lines(y=Sub_metering_2,x=datetime,col="red"))
with(obs, lines(y=Sub_metering_3,x=datetime,col="blue"))

# notice that in plot4 the legend box does not show its border: bty = "n" to achieve that.   
legend("topright",bty = "n",lty="solid",col = c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# third subplot 
with(obs,plot(y=Voltage,x=datetime, type = "n" ))
with(obs, lines(y=Voltage,x=datetime,col="black"))

# fourth subplot 
with(obs,plot(y=Global_reactive_power,x=datetime, type = "n" ,ylab = "Global_reactive_power"))
with(obs, lines(y=Global_reactive_power,x=datetime,col="black"))

dev.off()
