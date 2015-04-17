corr <- function(directory, threshold = 0) {
    
    # first thing's first - if the directory doesn't exist, not much that can be done
    if(!file.exists(directory)) {
        
        stop(paste("The provided directory '", directory, "' does not exist."))
    }
    
    # need to store our list of correlations somewhere
    correlations <- vector()
    
    # we're still here, let's iteratively examine each csv file in the provided dir
    for(csv in list.files(path = directory, pattern = "*.csv"m full.names = TRUE)) {
        
        file <- read.csv(csv)
        
        # if threshold is zero, not much to do
        if (threshold == 0) {
            
            correlations <- c(correlations, cor(file["nitrate"], file["sulfate"]))
            
        } else if (nrow(na.omit(file)) > threshold) {
            
            correlations <- c(correlations, cor(file["nitrate"], file["sulfate"]))
            
        }
    }
}