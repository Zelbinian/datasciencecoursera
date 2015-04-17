complete <- function(directory, id = 1:332) {
    
    # first thing's first - if the directory doesn't exist, not much that can be done
    if(!file.exists(directory)) {
        
        stop(paste("The provided directory '", directory, "' does not exist."))
    }
    
    # instantiating empty vectors to add to later
    stationIds <- vector()
    numObs <- vector()
    
    # we're still here? Great, let's loop!
    for (station in id) {
        
        # building the file name separately for better code readability
        file <- paste0(directory, '/', formatC(station, width = 3, flag = 0), '.csv')
        
        stationData <- read.csv(file)
        
        # I could do things with the id number before all this, but if the file doesn't
        # exist, we want to let read.csv throw the error. Best practice would be to
        # try-catch it, but I'm not sure how error handling works in R right now
        
        stationIds <- c(stationIds, station)
        numObs <- c(numObs, nrow(na.omit(stationData))) # counting rows without nas
    }
    
    # assembling for output
    output <- data.frame(stationIds, numObs)
    names(output) <- c("id", "nobs")
    output  
}