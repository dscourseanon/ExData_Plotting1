##Extracting data from file and loading into R; assuming file is in the working directory
## First identify classes and then use those to load in memory to reduce time
sampledata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows = 5)
classdata <- sapply(sampledata, class)
masterdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = classdata)

## Convert time and date data to appropriate classes
masterdata$Date <- as.Date(masterdata$Date, format = "%d/%m/%Y")
masterdata$Time <- strptime(paste(masterdata$Date, masterdata$Time), "%Y-%m-%d %T")

##Extract relevant data
relevantdata <- subset(masterdata, masterdata$Date == "2007-02-01" | masterdata$Date == "2007-02-02")

##Generate all 4 plots
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
plot(relevantdata$Time, relevantdata$Global_active_power, ylab = "Global Active Power", xlab="", type="l")
plot(relevantdata$Time, relevantdata$Voltage, ylab = "Voltage", xlab="datetime", type="l")
plot(relevantdata$Time, relevantdata$Sub_metering_1, ylab = "Energy sub metering", xlab="", type="l")
lines(relevantdata$Time, relevantdata$Sub_metering_2, col = "red")
lines(relevantdata$Time, relevantdata$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), bty = "n", col = c("black", "red", "blue"))
plot(relevantdata$Time, relevantdata$Global_reactive_power, ylab = "Global_reactive_power", xlab="datetime", type="l")
dev.off()