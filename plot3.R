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
png(file = "plot3.png", width = 480, height = 480, units = "px")

# open the graph
with(consumption, plot(dt, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering" ))
# add the lines
with(consumption, lines(dt, Sub_metering_1))
with(consumption, lines(dt, Sub_metering_2, col = "red"))
with(consumption, lines(dt, Sub_metering_3, col = "blue"))

# add the legend
legend("topright", col = c("black","blue", "red"), lty = 1, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()