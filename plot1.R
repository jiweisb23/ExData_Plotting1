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



#plot 1
png(file = "plot1.png")
hist(DF$Global_active_power, main = "Global Active Power", ylab = "Frequency", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()
