#Logs loss rate after various types of filtering (and performs the filtering)
loss_logger <- function(x){
  
  #Construct vector to save
  loss_log <- character(9)
  names(loss_log) <- c("Total requests",
                       "UTF-8 requests",
                       "Project requests",
                       "Production requests",
                       "Completed requests",
                       "External requests",
                       "Content requests",
                       "Non-API/Desired API requests",
                       "Non-SSL redirection requests")
  
  #Log initial rows
  loss_log[1] <- nrow(x)
  
  #Convert into UTF-8, removing those that, well, aren't UTF-8
  dailynames <- names(x)
  
  for(i in seq_along(dailynames)){
    
    #Replace with iconverted entries
    x[,dailynames[i]] <- iconv(x = x[,dailynames[i]], to = "UTF-8")
    
  }
  
  #Exclude incomplete cases
  x <- x[complete.cases(x),]
  
  #Log UTF-8 loss
  loss_log[2] <- nrow(x)
  
  #Remove non-text/html,application hits
  x <- x[x$MIME %in% accepted_MIMES,]
  
  #Log non-pageview loss
  loss_log[3] <- nrow(x)
  
  #Remove non-project hits
  x <- x[custodiet(x = x$URL, start = 1, end = 30, regex = project_sources, name = "non_project", ignore.case = TRUE),]
  
  #Log non-project loss
  loss_log[4] <- nrow(x)
  
  #Filter to completed, non-redirected requests
  x <- x[custodiet(x = x$status_code, start = 1, end = 20, regex = "(200|304)", name = "uncompleted"),]
  
  #Log those
  loss_log[5] <- nrow(x)
  
  #Format timestamps
  x$timestamp <- substring(x$timestamp,1,10)
  
  #Remove Internal sources of requests
  x <- x[!custodiet(x = x$UA, start = 1, end = 50, regex = internal_sources, name = "internal", perl = TRUE),]
  
  #Log
  loss_log[6] <- nrow(x)
  
  #Filter out non-content requests
  x <- x[custodiet(x = x$URL, start = 1, end = 50, regex = content_sources, name = "content"),]
  
  #Log
  loss_log[7] <- nrow(x)
  
  #Filter out undesired API requests
  x <- x[!custodiet(x = x$URL, start = 30, end = 60, regex = undesired_APIs, name = "api"),]
  
  #Log
  loss_log[8] <- nrow(x)
  
  #Filter out entries from SSL terminators
  x <- x[!custodiet(x = x$squid, start = 1, end = nchar(x$squid), regex = "ssl", name = "ssl"),]
  
  loss_log[9] <- nrow(x)
  
  #Write out
  write.table(x = loss_log,
              file = file.path(getwd(),"Logs",curdate,"loss_log.tsv"),
              quote = TRUE,
              sep = "\t")
  
  #Return the (now sanitised) original object
  return(x)
}