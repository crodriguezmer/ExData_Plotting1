rm(list=ls()) # start clean

# set directory
setwd('~/Google Drive/Courses/ExploratoryDataAnalysis/ExData_Plotting1')

# download and unzip files
url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(url, "hpc.zip", method="curl")
unzip("hpc.zip")

# # inspect the data to load only the necessary rows when reproducing
# hpc = read.csv("household_power_consumption.txt", header=T, sep=";") # load (takes a while)
# library(lubridate)
# hpc$Date = as.Date(as.character(hpc$Date), format="%d/%m/%Y")
# rows2use = which(year(hpc$Date) == 2007 & month(hpc$Date) ==2 & (day(hpc$Date) == 1 | day(hpc$Date)==2))
# skip=rows2use[1] # 66637
# nrows = length(rows2use) # 2880

# load only the data to be used, get names and recode date and time
hpc2 = read.csv("household_power_consumption.txt", header=F, sep=";", skip=66637, nrows=2880, as.is=T)
names(hpc2) = names(read.csv("household_power_consumption.txt", header=T, sep=";", skip=0, nrows=1, as.is=T))
hpc2$DT = strptime( paste(hpc2$Date, hpc2$Time), "%d/%m/%Y %H:%M:%S")
hpc2$Date = as.Date(hpc2$Date)
hpc2$Time = strptime(hpc2$Time,"%H:%M:%S")

# make a time series plot for each sub metering 
png(filename = "plot3.png", type = "quartz")
plot(hpc2$DT, hpc2$Global_active_power, 
     type = "n",
     xlab = '',
     yaxt= "n",
     ylim = c(0, 40),
     ylab = 'Energy submetering'
)
lines(hpc2$DT, hpc2$Sub_metering_1)
lines(hpc2$DT, hpc2$Sub_metering_2, col='red')
lines(hpc2$DT, hpc2$Sub_metering_3, col='blue')
axis(2, seq(0,30,10))
legend("topright", 
       c('Sub_metering_1', 'Sub_metering_2','Sub_metering_3'),
       lty=1,
       col=c('black','red','blue'))
dev.off()
