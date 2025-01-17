if(!file.exists("./data")){dir.create("./data")}
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
download.file(fileurl, "./data/UCI_HPC_dataset.zip")
unzip("./data/UCI_HPC_dataset.zip",exdir =  "./data")

top5rows <- read.table("./data/household_power_consumption.txt", header = T, nrows = 5, sep = ";")
classes <-sapply(top5rows,class)
hpc <- read.table("./data/household_power_consumption.txt", header = T,nrows = 2075259, sep = ";", colClasses = classes, comment.char = "", na.strings = "?")


hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")
range <- as.Date(c("2007-02-01", "2007-02-02"))
hpccut <- subset(hpc, Date %in% range)
rm(hpc)

hpccut$datetime <- with(hpccut, strptime(paste(Date, Time), "%Y-%m-%d %H:%M:%S"))
inthpccut <- hpccut[, c(10, 3:9)]


# plot 4
# Sys.setlocale("LC_TIME", "English")
# weekdays(Sys.Date()+0:6,abbreviate = T)

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))
with(
  inthpccut, 
  plot(datetime, Global_active_power, 
       type = "l", 
       xlab = "", 
       ylab = "Globall Active Power (kilowatts)"))



with(
  inthpccut, 
  plot(datetime, Voltage, 
       type = "l", 
       xlab = "", 
       ylab = "Voltage"))




with(inthpccut,
     plot(datetime, Sub_metering_1,
          type = "l",
          xlab = "",
          ylab = "Energy sub metering"))

with(inthpccut, 
     lines(datetime, Sub_metering_2, col = "red"))

with(inthpccut, 
     lines(datetime, Sub_metering_3, col = "blue"))

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = "solid", 
       col = c("black", "red", "blue"), 
       bty = "n")



with(inthpccut, 
     plot(datetime, Global_reactive_power,
          type = "l"))


dev.off()

