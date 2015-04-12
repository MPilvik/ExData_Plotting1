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

### Create the first plot
png(file="plot1.png", width=480, height=480, bg="transparent") # Open png-device and create a "plot1.png" file in the working directory. Background colour is set to transparent as in the examples in rdpeng's repository.
hist(DT$Global_active_power, col="red", main="Global active Power", xlab="Global Active Power (kilowatts)") # Draw the histogram and send to file.
dev.off() # Close the png-device.