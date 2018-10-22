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
png(file = "plot2.png")

# open the graph
with(consumption, plot(dt, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power(kilowatts)" ))

dev.off()