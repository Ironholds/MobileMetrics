mobilemetrics <- function(){
  
  #Load in config files, functions
  to_dispose <- lapply(list.files(file.path(getwd(),"Functions"), full.names = TRUE),source)
  source("config.R")
  
  #List files
  filelist <- list.files(path = "/a/squid/archive/sampled",
                         pattern = ".gz$",
                         full.names = TRUE)
  
  #Limit to the most recent one
  curfile <- filelist[length(filelist)]
  
  #Store the date
  curdate <- substring(text = curfile,
                       first = 48,
                       last = 55)
  
  #Read in the latest file
  dailydata <- file_reader(file = curfile)
  
  #Filter it, logging the filter results
  filtereddata <- loss_logger(x = dailydata)
}

Apps
-wikipanion