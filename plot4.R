library(lubridate)
library(dplyr)

# assuming that you already have the data from plot1.R
dataset <- "household_power_consumption.txt"

# The dataset has 2,075,259 rows and 9 columns.
# We will only be using data from the dates 2007-02-01 and 2007-02-02.
# One alternative is to read the data from just those dates rather than
# reading in the entire dataset and subsetting to those dates.
skip <- 66637
nrows <- 2880
headers <- read.csv(dataset, sep = ";", header = FALSE, nrows = 1, stringsAsFactors=FALSE)
data <- read.csv(dataset, header = FALSE, sep = ";", skip = skip, nrows = nrows, na.strings = c("?"))
names(data) <- as.character(as.vector(headers[1,]))

png(filename = "plot4.png", bg = "transparent")
par(mfrow = c(2, 2))

# plot 1
data1 <- data %>%
	mutate(Datetime = dmy_hms(paste(Date, Time))) %>%
	select(Datetime, Global_active_power)
plot(data1, type = "l", ylab = "Global Active Power", xlab = "")

# plot 2
data2 <- data %>%
	mutate(Datetime = dmy_hms(paste(Date, Time))) %>%
	select(Datetime, Voltage)
plot(data2, type = "l", ylab = "Voltage", xlab = "datetime")

# plot 3
data3 <- data %>%
	mutate(Datetime = dmy_hms(paste(Date, Time))) %>%
	select(Datetime, Sub_metering_1, Sub_metering_2, Sub_metering_3)

plot(data3$Datetime, data3$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(data3$Datetime, data3$Sub_metering_1)
lines(data3$Datetime, data3$Sub_metering_2, col = "red")
lines(data3$Datetime, data3$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), col = c("black", "red", "blue"), bty = "n")

# plot 4
data4 <- data %>%
	mutate(Datetime = dmy_hms(paste(Date, Time))) %>%
	select(Datetime, Global_reactive_power)
plot(data4, type = "l", xlab = "datetime")

dev.off()
