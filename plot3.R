# Download and unzip data file if it doesn't exist

zipUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "household_power_consumption.zip"

if (!file.exists(zipFile)) {
    download.file(zipUrl, zipFile, mode = "wb")
}
if (!file.exists("household_power_consumption.txt")) {
    unzip(zipFile)
}

# Read data for 1-2 Feb 2007

household <- read.table("household_power_consumption.txt",
                        skip=66637,nrows=2880,sep=";",na.strings="?")
hhheader <- read.table("household_power_consumption.txt",
                       nrows=1,sep=";",stringsAsFactors = FALSE)
names(household) <- unlist(hhheader)

# Reformat date and time

fulldate <- paste(household$Date,household$Time)
fulldate <- as.POSIXct(fulldate, "%d/%m/%Y %H:%M:%S", tz = "")

# Create Plot 3

png("plot3.png",width=480,height=480,units="px")
plot(fulldate,household$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(fulldate,household$Sub_metering_2, col="red")
lines(fulldate,household$Sub_metering_3, col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lty=1)
dev.off()