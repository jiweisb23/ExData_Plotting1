loc = getwd()
file_<- 'household_power_consumption.txt'
##df <- read.delim(paste(loc,file_, sep="/"), header= true, )
hdrs <- read.delim(paste(loc,file_, sep="/"), header = TRUE, sep = ";", nrows = 1)
text_<-""
cntFound = 0
cntNot = 0
for( line in readLines(file(paste(loc,file_, sep="/")))){
  if(substr(line,0,8 )=="1/2/2007" | substr(line,0,8 )=="2/2/2007"  ){
    text_<-paste(text_, line, sep = ",")
    hdrs <- rbind(hdrs, read.table(text = line, sep = ";", na.strings = "?", header = FALSE, col.names = colnames(hdrs)))
    cntFound = cntFound + 1
  }else{
    cntNot = cntNot+1
  }
}
text_<-substr(text_, 2, nchar(text_))
DF <-hdrs[grep("2007", hdrs$Date),]

DF$Time<-strptime(paste(DF$Date, DF$Time,sep = "-"), format = "%d/%m/%Y-%H:%M:%S" )
DF$Date<-as.Date(DF$Date, format = "%d/%m/%Y")




#plot 4
png(file = "plot4.png")
par(mfcol = c(2,2))

plot(DF$Time, DF$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", pch = NA)
lines(DF$Time, DF$Global_active_power)




plot(x=DF$Time, y=DF$Sub_metering_1, pch=NA, xlab = "", ylab = "Energy sub metering")
lines(DF$Time, DF$Sub_metering_1, col = "black")
lines(DF$Time, DF$Sub_metering_2, col = "red")
lines(DF$Time, DF$Sub_metering_3, col = "blue")
l<-c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
colors_<-c("black", "red", "blue")
legend("topright", legend = l,col = colors_, lty = 1, cex = .5, bty = "n" )



plot(DF$Time, DF$Voltage, xlab = "datetime", ylab = "Voltage", pch = NA)
lines(DF$Time, DF$Voltage)


plot(DF$Time, DF$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", pch = NA)
lines(DF$Time, DF$Global_reactive_power)

dev.off()






