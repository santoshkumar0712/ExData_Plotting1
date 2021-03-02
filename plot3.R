plotdata<-read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", 
                     colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
plotdata$Date <- as.Date(plotdata$Date, "%d/%m/%Y")

## Filter Data between Feb 1,2007 to Feb 2,2007
plotdata<-subset(plotdata,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

##Combine Date and Time
datetime<-paste(plotdata$Date,plotdata$Time,sep = " ")

## Add New Column in Data
fin_plotdata<-cbind(datetime,plotdata)

## Format dateTime Column
fin_plotdata$datetime <- as.POSIXct(datetime)

##polt
with (fin_plotdata,
      {plot(Sub_metering_1~datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
      lines(Sub_metering_2~datetime, col='Red')
      lines(Sub_metering_3~datetime, col='Blue')
      })
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save plot on graphic device
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()