#Load in config files, functions
to_dispose <- lapply(list.files(file.path(getwd(),"Functions"), full.names = TRUE, pattern = "*.R"),source)
source("config.R")
source("globalstrings.R")

mobilemetrics <- function(){
  
  #RequestLog parser
  rl_parse <- function(curfile, desired_columns = c("timestamp","x_forwarded","UA","device","os","browser","browser_version")){
    
    #Store the date
    assign("curdate", value = substring(text = curfile,
                         first = 48,
                         last = 55),
           envir = globalenv())
    
    #Read in the latest file
    dailydata <- file_reader(file = curfile)
    
    #Filter it, logging the filter results
    dailydata <- loss_logger(x = dailydata)
    
    #Identify user agents
    dailydata <- ua_parse(dailydata)
    
    #Return
    return(dailydata[,desired_columns])
    
  }
  
  #List files
  filelist <- list.files(path = "/a/squid/archive/sampled",
                         pattern = ".gz$",
                         full.names = TRUE)
  
  #Limit to the most recent month
  curfiles <- filelist[(length(filelist)-29):length(filelist)]
  
  #Run rl_parse over the files
  recent_data <- lapply(curfiles, rl_parse)
  
  #Bind the resulting list into a single dataframe
  recent_data <- do.call("rbind",recent_data)

}
mobilemetrics()

q(save = "no")