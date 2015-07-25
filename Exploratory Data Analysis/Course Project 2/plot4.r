# lock 'n load
require(ggplot2)
require(dplyr)

# yo, you got my files?
fileRegEx = "summarySCC_PM25.rds|Source_Classification_Code.rds")

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