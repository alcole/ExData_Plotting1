## assumes the data has been unzipped
## start in directory that has the data in a subfolder
dir <- "exdata_data_household_power_consumption"
file <- "household_power_consumption.txt"

## get the column names for the table
header <- read.table(paste(dir,file,sep="/"), header = FALSE, sep = ";", nrows = 1)

## read in only the required dates, then add the column names to the data
consumption <- read.table(paste(dir,file,sep="/"), comment.char = "#", header = FALSE, sep = ";", na.strings = "?", skip = 66637, nrows = 2880)
colnames(consumption) <- unlist(header)

consumption$dt <- strptime(paste(consumption$Date, consumption$Time), "%d/%m/%Y %H:%M:%S")


## open the file
png(file = "plot4.png")

# intialise the pane, to add graphs by column
par(mfcol = c(2, 2))

#1st graph
with(consumption, plot(dt, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power" ))

#2nd graph

with(consumption, plot(dt, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering" ))
# add the lines
with(consumption, lines(dt, Sub_metering_1))
with(consumption, lines(dt, Sub_metering_2, col = "red"))
with(consumption, lines(dt, Sub_metering_3, col = "blue"))

# add the legend
legend("topright", col = c("black","blue", "red"),bty="n", lty = 1, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#3rd graph
with(consumption, plot(dt, Voltage, type = "l", xlab = "datetime", ylab = "Voltage" ))

#4th graph
with(consumption, plot(dt, Global_reactive_power, type = "l", xlab = "datetime"))
dev.off()
