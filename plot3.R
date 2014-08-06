#This code use the library data.table for the fread command, and datasets for graphics
library(data.table)
library(datasets)

#Initialization of the recording on a png with 480x480 of resolution
png(file = "plot3.png", units = "px", bg = "transparent", width=480, height=480)

#Let's start to import data, specifying the separator, and uniforming the missing values with "NA" 
DT <- fread("household_power_consumption.txt", sep=";", header=TRUE, na.strings=c("", "?"))

#The exercise asks to plot only data from two days: 2007-02-01 and 2007-02-02. Here there's the selection of the days requested
dates <- c(as.Date("2007-02-01"),as.Date("2007-02-02"))
subset_data <- subset(DT, as.Date(DT$Date, format="%d/%m/%Y") %in% dates)

#The next step plots the information about the Sub_metering information of the two days requested, in the right format.
#The conversion with "as.numeric" is done because the values in subset_data are characters.
#Type = "l" is to connect with lines the points on the axis. xaxt, and xlab are used to hide the informations that are not in the example.
#The type of graph is "with" for multiple lines
with(subset_data, plot(as.numeric(Sub_metering_1), type = "l", xaxt = "n", ylab = "Energy sub metering", xlab = ""))
with(subset_data, lines(Sub_metering_2, col = "red"))
with(subset_data, lines(Sub_metering_3, col = "blue"))

#Set up of the legend
legend("topright", lty = 1 , col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#As the x-axis should have the days of the week as labels, here there's the preparation of labels (days already selected + Saturday as ending point). 
dates <- c(dates, as.Date("2007-02-03"))

#The days should be written in English
Sys.setlocale("LC_TIME", "C")

#The next instruction sets the x-axis lables 
xaxis_label <- format(dates, "%a")

#The data are composed by 1440 values for each day, print x_axis every 1440 values
axis(1, at=c(0,1440,2880), xaxis_label)

#End of the recording on png
dev.off()