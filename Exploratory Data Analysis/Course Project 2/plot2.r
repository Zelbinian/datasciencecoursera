# yo, you got my files?
fileRegEx = "summarySCC_PM25.rds"

if(length(dir(pattern = fileRegEx)) != 1) {
    # no? laaazyyyyyyy. i'll download 'em for you
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                  "plotData.zip")
    unzip("plotData.zip")
    # you owe me a soda
}

# k, let's take a look
NEI <- readRDS("summarySCC_PM25.rds")

# gonna only look at Baltimore, because The Wire was dope
NEIbalt <- NEI[NEI$fips == "24510",]

# makin' sums
pm25sums <- with(NEIbalt, tapply(Emissions, as.factor(year), sum))

# i made you this picture - you like it?
png("plot2.png")
plot(names(pm25sums), pm25sums, type = "b", col = "blue", xlab = "Year", xaxt = "n",
     ylab = "Total PM2.5 Emissions", main = "Trendline of PM2.5 Emissions in Baltimore")
axis(1, names(pm25sums))
dev.off()