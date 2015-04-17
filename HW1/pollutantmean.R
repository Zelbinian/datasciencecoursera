pollutantmean <- function(directory = "specdata", pollutant, id = 1:332) {
    
    # first thing's first - if the directory doesn't exist, not much that can be done
    if(!file.exists(directory)) {
        
        stop(paste("The provided directory '", directory, "' does not exist."))
    }
    
    # need to loop through the files we care about, find the pollutant, and 
    #for (station in id) {
        
        # 
    #    stationDataCSV <- paste(paste(directory,id,sep='/'),".csv",sep=''
                                
    #                            stationData <- read.csv(directory)
                                
    #}
    
}