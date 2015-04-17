corr <- function(directory, threshold = 0) {
    
    # first thing's first - if the directory doesn't exist, not much that can be done
    if(!file.exists(directory)) {
        
        stop(paste("The provided directory '", directory, "' does not exist."))
    }
    
    # need to store our list of correlations somewhere
    correlations <- numeric()
    
    # we're still here, let's iteratively examine each csv file in the provided dir
    for(csv in list.files(path = directory, pattern = "*.csv", full.names = TRUE)) {
        
        # reading the csv and omitting na rows in one fell swoop
        file <- na.omit(read.csv(csv)) 
        
        # only do the correlation thing on this file if rows > threshold
        if(nrow(file) > threshold) {
            
            correlations <- c(correlations, cor(file["nitrate"], file["sulfate"]))
            
        }
    }
    
    correlations
}