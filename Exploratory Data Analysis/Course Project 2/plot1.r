# yo, you got my files?
fileRegEx = "summarySCC_PM25.rds"

if(length(dir(pattern = fileRegEx)) != 2) {
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
plot(names(pm25sums), pm25sums, type = "b", col = "blue", xlab = "Year", 
     ylab = "Total PM25 Emissions", main = "Trendline of PM25 Emissions over Time")
text(c(1999, 2002, 2005, 2008), pm25sums, names(pm25sums), pos = c(1,1,1,2))
