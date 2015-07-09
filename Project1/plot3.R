setwd("D:\\nauka\\R\\Course3");
path<-getwd()

#read logs
library(data.table)
#2007-02-01 and 2007-02-02
rows<-grep("^1.2.2007|^2.2.2007",readLines("household_power_consumption.txt"))
#read header
colnames <- read.table(file.path(path, "household_power_consumption.txt"), sep = ";", strip.white = TRUE, blank.lines.skip=TRUE, fill=TRUE, stringsAsFactors=F, quote = "", comment.char = "", na.strings="?", nrows=1)
#read only rows
start <- min(rows) - 1
nroows <- max(rows) - min(rows) + 1
epc<-read.table(file.path(path, "household_power_consumption.txt"), sep = ";", strip.white = TRUE, blank.lines.skip=TRUE, fill=TRUE, stringsAsFactors=F, quote = "", comment.char = "", na.strings="?", nrows=nroows, skip = start, header=FALSE)

setnames(epc,as.array(t((colnames))))

#see what's there
#summary(epc)
#describe(epc)
#str(epc)
#
# check values ok
#library(sqldf)
#sqldf("select date, count(*) c  from epc group by date order by 2 desc")



#Convert to date
epc$full_date<-paste(as.character(epc$Date), as.character(epc$Time), sep=' ')
epc$full_date <- as.POSIXct(epc$full_date, format="%d/%m/%Y %H:%M:%S")



plot.new()
plot(x=epc$full_date, y=epc$Sub_metering_1, col="black", main="", ylab="Energy sub metering", xlab="", type="l")
lines(x=epc$full_date, y=epc$Sub_metering_2, col="red")
lines(x=epc$full_date, y=epc$Sub_metering_3, col="blue")
legend("topright", lty = 1, col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#480 pixels and a height of 480 pixels

png(filename = "plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA)
plot(x=epc$full_date, y=epc$Sub_metering_1, col="black", main="", ylab="Energy sub metering", xlab="", type="l")
lines(x=epc$full_date, y=epc$Sub_metering_2, col="red")
lines(x=epc$full_date, y=epc$Sub_metering_3, col="blue")
legend("topright", lty = 1, col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off() ## Close the PDF file device
