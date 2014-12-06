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

data <- data %>%
	mutate(Datetime = dmy_hms(paste(Date, Time))) %>%
	select(Datetime, Global_active_power)

png(filename = "plot2.png", bg = 'transparent')
plot(data, ylab = "Global Active Power (kilowatts)", pch = NA, xlab = "")
lines(data$Datetime, data$Global_active_power)
dev.off()
