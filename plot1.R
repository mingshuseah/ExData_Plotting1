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

# Create Plot 1

png("plot1.png",width=480,height=480,units="px")
hist(household$Global_active_power,col="red",
     main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()