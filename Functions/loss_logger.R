#Logs loss rate after various types of filtering (and performs the filtering)
loss_logger <- function(x){
  
  #Construct vector to save
  loss_log <- character(6)
  names(loss_log) <- c("Total requests",
                       "UTF-8 requests",
                       "Production requests",
                       "Project requests",
                       "Completed requests",
                       "External requests")
  
  #Log initial rows
  loss_log[1] <- nrow(x)
  
  #Convert into UTF-8, removing those that, well, aren't UTF-8
  dailynames <- names(x)
  
  for(i in seq_along(dailynames)){
    
    #Replace with iconverted entries
    x[,dailynames[i]] <- iconv(x = x[,dailynames[i]], to = "UTF-8")
    
    #Remove rows with newly-introduced NAs
    x <- x[!is.na(x[,dailynames[i]]),]
    
  }
  
  #Log UTF-8 loss
  loss_log[2] <- nrow(x)
  
  #Remove non-project hits
  x <- x[grepl(pattern = "(((commons|meta|species)\\.wikimedia)|wik(tionary|isource|ibooks|ivoyage|iversity|iquote|inews|ipedia|idata))",
               x = x$URL,
               ignore.case = TRUE),]
    
  #Log non-project loss
  loss_log[3] <- nrow(x)
  
  #Remove non-text/html,application hits
  x <- x[x$MIME %in% accepted_MIMES,]
  
  #Log non-pageview loss
  loss_log[4] <- nrow(x)
  
  #Filter to completed, non-redirected requests
  x <- x[grepl(x = x$status_code, pattern = "200"),]
  
  #Log those
  loss_log[5] <- nrow(x)
  
  #Format timestamps
  x$timestamp <- strptime(substring(x$timestamp,1,13), format = "%Y-%m-%dT%H")
  
  #Remove Internal sources of requests
  x <- x[!grepl(x = x$UA, pattern = internal_sources),]
  
  #Log
  loss_log[6] <- nrow(x)
  
  #Write out
  write.table(x = loss_log,
              file = file.path(getwd(),"Logs",paste(curdate,"loss_log.tsv", sep = "_")),
              quote = TRUE,
              sep = "\t")
  
  #Return the (now sanitised) original object
  return(x)
}