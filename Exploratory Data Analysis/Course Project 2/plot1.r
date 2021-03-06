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

# gotta sum this sucka
pm25sums <- with(NEI, tapply(Emissions, as.factor(year), sum))

# like my art skills?
png("plot1.png")
plot(names(pm25sums), pm25sums, type = "b", col = "blue", lwd = 2, xlab = "Year", xaxt = "n",
     yaxt = "n", ylim = c(3000000,8000000), ylab = "Total PM2.5 Emissions (millions)",
     main = "Trendline of PM2.5 Emissions in the United States")
axis(1, names(pm25sums))
axis(2, seq(3000000,8000000,500000), label = seq(3,8,.5))
dev.off()
