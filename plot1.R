##Extracting data from file and loading into R
## First identify classes and then use those to load in memory to reduce time
sampledata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows = 5)
classdata <- sapply(sampledata, class)
masterdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = classdata)

## Convert time and date data to appropriate classes
masterdata$Date <- as.Date(masterdata$Date, format = "%d/%m/%Y")
masterdata$Time <- strptime(paste(masterdata$Date, masterdata$Time), "%Y-%m-%d %T")

##Extract relevant data
relevantdata <- subset(masterdata, masterdata$Date == "2007-02-01" | masterdata$Date == "2007-02-02")

##Generate histogram
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(relevantdata$Global_active_power, breaks = 12, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red", main = "Global Active Power")
dev.off()