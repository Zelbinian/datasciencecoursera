# we're gonna need a bigger boat
require(ggplot2)
require(dplyr)

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

# gonna only look at Baltimore; sorry NYC maybe next time
NEIbalt <- NEI[NEI$fips == "24510",]

# whoa dog, we need to mix this up and make a "total emissions by type" dataset
tebt <- group_by(NEIbalt, type, year) %>% summarize(totEmissions = sum(Emissions))

# alriiiight, now watch my fancy pixel work
qplot(year, totEmissions, data = tebt, color = type, geom = 'line', 
      main = "Pollutants in Baltimore Over Time", xlab = "Year", ylab="Total Emissions")