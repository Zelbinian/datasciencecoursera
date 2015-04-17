pollutantmean <- function(directory = "specdata", pollutant, id = 1:332) {
  
  # need to loop through the files we care about, find the pollutant, and 
  for (station in id) {
    
    # 
    stationDataCSV <- paste(paste(directory,id,sep='/'),".csv",sep=''
    
    stationData <- read.csv(directory)
    
  }
  
}