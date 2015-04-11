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

# make a time series plot 
png(filename = "plot2.png", type = "quartz")
plot(hpc2$DT, hpc2$Global_active_power, 
     type = "l",
     xlab = '',
     ylab = 'Global active power (kilowatts)'
     )
dev.off()
