### Download the zip-file.
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="exdata_data_household_power_consumption.zip")

### Unzip the zip-file.
data_unzipped <- unzip("exdata_data_household_power_consumption.zip")

### Read in the data, specifying the strings to be handled as missing values ("?") and setting stringsAsFactors to FALSE in order to be able to paste dates and times together later.
DT0 <- read.table("household_power_consumption.txt", na.strings="?", stringsAsFactors=F, header=T, sep=";")

### Subset the data, selecting only observations from the two dates.
DT <- subset(DT0, Date=="1/2/2007" | Date=="2/2/2007", droplevels=T)

### Create a new variable "DateTime" by pasting the Date and Time variables together.
DT$DateTime <- paste(as.character(DT$Date), as.character(DT$Time), sep=" ")

### Convert the DateTime strings to Date/Time class.
DT$DateTime <- strptime(DT$DateTime, "%d/%m/%Y %H:%M:%S")

### Set aspects of the locale for the R process in order to show the names of the weekdays in English (the server's base language). 
Sys.setlocale("LC_ALL", "C")

### Create the third plot.
png(file="plot3.png", width=480, height=480, bg="transparent") # Open png-device and create a "plot1.png" file in the working directory. Background colour is set to transparent as in the examples in rdpeng's repository.
with(DT, plot(DT$DateTime, DT$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")) # Create an empty base plot with relevant annotation on the axes.
with(subset(DT, select=Sub_metering_1), lines(DT$DateTime, DT$Sub_metering_1, col="black")) # Fill the plot with the data from variable "Sub_metering_1".
with(subset(DT, select=Sub_metering_2), lines(DT$DateTime, DT$Sub_metering_2, col="red")) # Add data from variable "Sub_metering_2".
with(subset(DT, select=Sub_metering_3), lines(DT$DateTime, DT$Sub_metering_3, col="blue")) # Add data from variable "Sub_metering_3".
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, cex=0.955) # Add legend to the topright corner of the plot, specifying the line type (solid=1), colours and labels. Also, slightly shrink the plotting text and symbols on the legend.
dev.off() # Close the png-device.