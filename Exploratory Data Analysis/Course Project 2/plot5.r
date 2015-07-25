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

# hey Baltimore NEI data, how you doin?
NEIbalt <- NEI[NEI$fips == "24510",]

# now you just want vehicles? geez, you owe me TWO sodas
SCCvehicleIDs <- SCC[grep("Vehicles", SCC$SCC.Level.Two, value = F),]$SCC

# k, i got you those ids, right? gonna make everything else *poof* disappear
baltCarPollutants <- NEIbalt[NEIbalt$SCC %in% SCCvehicleIDs,]

# gotta sum this sucka
pm25sums <- with(baltCarPollutants, tapply(Emissions, as.factor(year), sum))

# hang this on yo fridge
png("plot5.png")
plot(names(pm25sums), pm25sums, type = "b", col = "purple", xlab = "Year", xaxt = "n",
     lwd = 2, ylab = "Total PM2.5 Emissions",
     main = "Trendline of Vehicle Emissions in the Baltimore")
axis(1, names(pm25sums))
dev.off()