#Load in config files, functions
to_dispose <- lapply(list.files(file.path(getwd(),"Functions"), full.names = TRUE, pattern = "*.R"),source)
source("config.R")
source("globalstrings.R")

mobilemetrics <- function(){
  
  #RequestLog parser
  rl_parse <- function(curfile){
    
    #Store the date
    curdate <<- substring(text = curfile, first = 47, last = 54)
    
    #Create the logging directory
    dir.create(file.path(getwd(),"Logs",curdate), showWarnings = FALSE)
    
    #Read in the latest file
    dailydata <- file_reader(file = curfile)
    
    #Filter it, logging the filter results
    dailydata <- loss_logger(x = dailydata)
    
    #Identify user agents
    dailydata <- ua_parse(dailydata)
    
    #Handle initial tagging
    dailydata <- tag_logger(x = dailydata)
    
    return(dailydata)
  }
  
  #List files
  filelist <- list.files(path = "/a/squid/archive/sampled",
                         pattern = ".gz$",
                         full.names = TRUE)
  
  #Limit to the most recent month
  curfiles <- filelist[(length(filelist)-30):(length(filelist)-1)]
  
  #Run rl_parse over the files
  recent_data <- lapply(curfiles, rl_parse)
  
  #Bind the resulting list into a single dataframe
  recent_data <- do.call("rbind",recent_data)
  
  #Save
  save(recent_data, file = "recent.RData")
  
  #Analyse
  manguel(recent_data)

}

mobilemetrics()

q(save = "no")