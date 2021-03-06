#Load in config files, functions
to_dispose <- lapply(list.files(file.path(getwd(),"Functions"), full.names = TRUE, pattern = "*.R"),source)
source("config.R")
source("globalstrings.R")

mobilemetrics <- function(){
  
  #RequestLog parser
  rl_parse <- function(curfile){
    
    #Start timing test
    time_test <- data.frame()
    
    #Store the date
    curdate <<- substring(text = curfile, first = 47, last = 54)
    
    #Create the logging directory
    dir.create(file.path(getwd(),"Logs",curdate), showWarnings = FALSE)
    
    #Read in the latest file
    time_test <- rbind(time_test,c("file_read",system.time({
      dailydata <- file_reader(file = curfile)
    })))
    
    #Filter it, logging the filter results
    time_test <- rbind(time_test, c("filter",system.time({
      dailydata <- loss_logger(x = dailydata)
    })))
    
    #Identify user agents
    time_test <- rbind(time_test, c("identification",system.time({
      dailydata <- ua_parse(x = dailydata, data = c("device","os","browser","browser_version"))
    })))
    
    #Handle initial tagging
    time_test <- rbind(time_test, c("tagging",system.time({
      dailydata <- tag_logger(x = dailydata)
    })))
    
    #Write out time_test
    names(time_test) <- c("stage","user.self","sys.self","elapsed","user.child","sys.child")
    write.table(time_test,
                file = file.path(getwd(),"Logs",curdate,"time_log.tsv"),
                quote = TRUE,
                sep = "\t",
                row.names = FALSE)
    
    #Return
    return(dailydata)
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
  
  #Limit
  recent_data <- recent_data[, desired_columns]
  
  #Save
  save(recent_data, file = paste(curdate,"recent.RData",sep = "_"))
  
  #Analyse
  manguel(recent_data)

}

mobilemetrics()

q(save = "no")