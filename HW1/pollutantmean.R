pollutantmean <- function(directory = "specdata", pollutant, id = 1:332) {
    
    # first thing's first - if the directory doesn't exist, not much that can be done
    if(!file.exists(directory)) {
        
        stop(paste("The provided directory '", directory, "' does not exist."))
    }
    
    # variables we'll need for the final calculation
    pollutantSum <- 0
    numEntries <- 0
    
    # we're still here? Great, let's loop!
    for (station in id) {
        
        # building the file name separately for better code readability
        file <- paste0(directory, '/', formatC(station, width = 3, flag = 0), '.csv')                      
        
        stationData <- read.csv(file)   
        p <- stationData[pollutant]     
        p <- p[!is.na(p)]               # clearing out NA values
        
        pollutantSum <- pollutantSum + sum(p)
        numEntries <- numEntries + length(p)
    }
    
    pollutantSum / numEntries   # finally, return the mean
    
}