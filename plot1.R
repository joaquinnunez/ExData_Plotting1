library(lubridate)
library(dplyr)

# getting the data if is not present
dataset <- "household_power_consumption.txt"
if (!file.exists(dataset)) {
  print("Dataset is not present")
  zip.filename <- "household_power_consumption.zip"
  if (!file.exists(zip.filename)) {
    print("Zip file is not present, downloading...")
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, zip.filename, method = "curl")
  }
  print("Unzipping file...")
  unzip(zip.filename)
}

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
	select(Datetime, Global_active_power, Global_reactive_power, Voltage,
		Global_intensity, Sub_metering_1, Sub_metering_2, Sub_metering_3)
