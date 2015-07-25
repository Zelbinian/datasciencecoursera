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

# you want coal? ok, whatever you say, santa, finding all point coal emissions
# i figure EI.Sectors that have "coal" in the description is what you want
# so subsetting based on that and then grabbing those ids
SCCcoalIDs <- SCC[grep("[c|C]oal", SCC$EI.Sector, value = F),]$SCC

# k, i got you those ids, right? gonna make everything else *poof* disappear
coalPollutants <- NEI[NEI$SCC %in% SCCcoalIDs,]

# gotta sum this sucka
pm25sums <- with(coalPollutants, tapply(Emissions, as.factor(year), sum))

# hang this on yo fridge
png("plot4.png")
plot(names(pm25sums), pm25sums, type = "b", col = "red", xlab = "Year", xaxt = "n",
     ylab = "Total PM2.5 Emissions",
     main = "Trendline of Coal Emissions in the United States")
axis(1, names(pm25sums))
dev.off()