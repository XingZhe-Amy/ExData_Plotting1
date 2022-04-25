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

png(filename = "plot1.png", width = 480, height = 480)
hist(inthpccut$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()