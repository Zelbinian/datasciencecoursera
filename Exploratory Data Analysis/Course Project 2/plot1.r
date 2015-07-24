# Yo, you got my files?
fileRegEx = "Source_Classification_Code.rds|summarySCC_PM25.rds"

if(length(dir(pattern = fileRegEx)) != 2) {
    # no? laaazyyyyyyy. I'll download 'em for you.
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                  "plotData.zip")
    unzip("plotData.zip")
    # you owe me a soda
}

# k, let's take a look
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")