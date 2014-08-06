#This code use the library data.table for the fread command, and datasets for graphics
library(data.table)
library(datasets)

#Initialization of the recording on a png with 480x480 of resolution
png(file = "plot1.png", units = "px", bg = "transparent", width=480, height=480)

#Let's start to import data, specifying the separator, and uniforming the missing values with "NA" 
DT <- fread("household_power_consumption.txt", sep=";", header=TRUE, na.strings=c("", "?"))

#The exercise asks to plot only data from two days: 2007-02-01 and 2007-02-02. Here there's the selection of the days requested
subset_data <- subset(DT, as.Date(DT$Date, format="%d/%m/%Y") %in% c(as.Date("2007-02-01"),as.Date("2007-02-02")))

#The next step plots the information about Global_active_power of the two days requested, taking care about the colors and labels.
# the conversion with "as.numeric" is done because the values in subset_data are characters.
hist(as.numeric(subset_data$Global_active_power), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#End of the recording on png
dev.off()