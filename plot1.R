library(data.table)
library(dplyr)

## read the data
pdata <- fread("./household_power_consumption.txt", colClasses = "character")
pdata <- tbl_df(pdata)

## convert class of Date column to date
pdata <- mutate(pdata, Date=as.Date(Date, format="%d/%m/%Y"))

## subset for the first two days of February 2007 
## I add the Date_Time column first before binding, otherwise 
## the as.Date() function only copies the first date
pdata2 <- filter(pdata, Date=="2007-02-01")
pdata2 <- mutate(pdata2, Date_Time=as.POSIXct(paste(Date, Time)))

pdata3 <- filter(pdata, Date=="2007-02-02")
pdata3 <- mutate(pdata3, Date_Time=as.POSIXct(paste(Date, Time)))

pdata <- bind_rows(pdata2, pdata3)

## convert class of other columns from char to numeric
pdata <- mutate(pdata, Global_active_power=as.numeric(Global_active_power), 
                Global_reactive_power=as.numeric(Global_reactive_power), 
                Voltage=as.numeric(Voltage), 
                Global_intensity=as.numeric(Global_intensity), 
                Sub_metering_1=as.numeric(Sub_metering_1), 
                Sub_metering_2=as.numeric(Sub_metering_2), 
                Sub_metering_3=as.numeric(Sub_metering_3))


## create plot
hist(pdata$Global_active_power, 
     col="red", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency")
