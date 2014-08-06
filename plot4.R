#This code use the library data.table for the fread command, and datasets for graphics
library(data.table)
library(datasets)

#Initialization of the recording on a png with 480x480 of resolution
png(file = "plot4.png", units = "px", bg = "transparent", width=480, height=480)

#Let's start to import data, specifying the separator, and uniforming the missing values with "NA" 
DT <- fread("household_power_consumption.txt", sep=";", header=TRUE, na.strings=c("", "?"))

#The exercise asks to plot only data from two days: 2007-02-01 and 2007-02-02. Here there's the selection of the days requested
dates <- c(as.Date("2007-02-01"),as.Date("2007-02-02"))
subset_data <- subset(DT, as.Date(DT$Date, format="%d/%m/%Y") %in% dates)

par( mfrow = c( 2, 2 ) )


##First plot row 1 col 1

#Plot of the information on Global_active_power, as specified in the exercise.
plot(as.numeric(subset_data$Global_active_power), type = "l", xaxt = "n",  xlab = "", ylab = "Global Active Power")


# As the x-axis should have the days of the week as labels, here there's the preparation of labels (days already selected + Saturday as ending point). 
dates <- c(dates, as.Date("2007-02-03"))

# The days should be written in English
Sys.setlocale("LC_TIME", "C")

# The next instruction sets the x-axis lables 
xaxis_label <- format(dates, "%a")

# The data are composed by 1440 values for each day, print x_axis every 1440 values
axis(1, at=c(0,1440,2880), xaxis_label)


##second plot row 1 col 2

#Plot of the information on Voltage, as specified in the exercise.
plot(as.numeric(subset_data$Voltage), type = "l", xaxt = "n",  xlab = "datetime", ylab = "Voltage")

# The data are composed by 1440 values for each day, print x_axis every 1440 values
axis(1, at=c(0,1440,2880), xaxis_label)


##Third plot row 2 col 1

#Plot of the information on Sub_meterings, as specified in the exercise.
with(subset_data, plot(as.numeric(Sub_metering_1), type = "l", xaxt = "n", ylab = "Energy sub metering", xlab = ""))
with(subset_data, lines(Sub_metering_2, col = "red"))
with(subset_data, lines(Sub_metering_3, col = "blue"))

#Set up of the legend
legend("topright", lty = 1 , col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")

#The data are composed by 1440 values for each day, print x_axis every 1440 values
axis(1, at=c(0,1440,2880), xaxis_label)


##Fourth plot row 2 col 2

#Plot of the information on Global_reactive_power, as specified in the exercise.
plot(as.numeric(subset_data$Global_reactive_power), type = "l", xaxt = "n",  xlab = "datetime", ylab = "Global_reactive_power")

#The data are composed by 1440 values for each day, print x_axis every 1440 values
axis(1, at=c(0,1440,2880), xaxis_label)


#End of the recording on png
dev.off()