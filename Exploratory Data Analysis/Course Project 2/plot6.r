# yo, you got my files?
fileRegEx = "summarySCC_PM25.rds|Source_Classification_Code.rds"

if(length(dir(pattern = fileRegEx)) != 2) {
    # no? laaazyyyyyyy. i'll download 'em for you
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                  "plotData.zip")
    unzip("plotData.zip")
    # you owe me a soda
}

# k, let's take a look
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Baltimore you're invited to the party 
NEIbalt <- NEI[NEI$fips == "24510",]
# ... and I guess your friend LA can come, too, just make sure he doesn't get drunk this time
NEIla <- NEI[NEI$fips == "06037",]

# now you just want vehicles? geez, you owe me TWO sodas
SCCvehicleIDs <- SCC[grep("Vehicles", SCC$SCC.Level.Two, value = F),]$SCC

# k, i got you those ids, right? gonna make everything else *poof* disappear
baltCarPollutants <- NEIbalt[NEIbalt$SCC %in% SCCvehicleIDs,]
laCarPollutants <- NEIla[NEIla$SCC %in% SCCvehicleIDs,]

# time to sum things up
pm25sumsBalt <- with(baltCarPollutants, tapply(Emissions, as.factor(year), sum))
pm25sumsLA <- with(laCarPollutants, tapply(Emissions, as.factor(year), sum))

# this is the last plot I'm making for you, I need some whiskey in me
png("plot6.png")
plot(names(pm25sumsBalt), pm25sumsBalt, type = "b", col = "orange", xlab = "Year", xaxt = "n",
     lwd = 2, ylab = "Total PM2.5 Emissions", ylim = c(0, 5000),
     main = "Trendline of Vehicle Emissions in Baltimore vs LA")
lines(names(pm25sumsLA), pm25sumsLA, type = "b", col = "black", lwd = 2)
axis(1, names(pm25sumsBalt))
legend("topright", lty=c(1,1), bty="n", col = c("orange", "black"), 
       legend = c("Baltimore", "LA"))
dev.off()
