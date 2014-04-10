#Logs loss rate after various types of filtering (and performs the filtering)
loss_logger <- function(x){
  
  #Construct vector to save
  loss_log <- character(5)
  names(loss_log) <- c("Total requests",
                       "UTF-8 requests",
                       "Production requests",
                       "Project requests",
                       "Completed requests")
  
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
  x <- x[grepl(pattern = "((commons|meta|species)\\.(m\\.)?wikimedia|(wik(tionary|isource|ibooks|ivoyage|iversity|iquote|inews|ipedia|idata))\\.org)",
               x = x$URL,
               ignore.case = TRUE),]

  #Log non-project loss
  loss_log[3] <- nrow(x)
  
  #Remove non-text/html,application hits
  x <- x[x$MIME %in% c("text/html; charset=UTF-8",
                       "text/html; charset=utf-8",
                       "text/html; charset=iso-8859-1",
                       "text/html; charset=ISO-8859-1",
                       "text/html",
                       "application/vnd.php.serialized; charset=utf-8",
                       "application/vnd.php.serialized; charset=UTF-8",
                       "application/vnd.php.serialized; charset=iso-8859-1",
                       "application/vnd.php.serialized; charset=ISO-8859-1",
                       "application/vnd.php.serialized",
                       "application/json; charset=utf-8",
                       "application/json; charset=UTF-8",
                       "application/json; charset=iso-8859-1",
                       "application/json; charset=ISO-8859-1",
                       "application/json",
                       "text/xml; charset=utf-8",
                       "text/xml; charset=UTF-8",
                       "text/xml; charset=iso-8859-1",
                       "text/xml; charset=ISO-8859-1",
                       "text/xml",
                       "application/x-www-form-urlencoded; charset=UTF-8",
                       "application/x-www-form-urlencoded; charset=utf-8",
                       "application/x-www-form-urlencoded; charset=iso-8859-1",
                       "application/x-www-form-urlencoded; charset=ISO-8859-1",
                       "application/x-www-form-urlencoded",
                       "application/xml; charset=UTF-8",
                       "application/xml; charset=utf-8",
                       "application/xml; charset=iso-8859-1",
                       "application/xml; charset=ISO-8859-1",
                       "application/xml",
                       "application/yaml; charset=utf-8",
                       "application/yaml; charset=UTF-8",
                       "application/yaml; charset=iso-8859-1",
                       "application/yaml; charset=ISO-8859-1",
                       "application/yaml"
                       ),]
  
  #Log non-pageview loss
  loss_log[4] <- nrow(x)
  
  #Filter to completed, non-redirected requests
  x <- x[grepl(x = x$status_code, pattern = "200"),]
  
  #Log those
  loss_log[5] <- nrow(x)
  
  #Write out
  write.table(x = loss_log,
              file = file.path(getwd(),"Logs",paste(curdate,"metadata.tsv", sep = "_")),
              quote = TRUE,
              sep = "\t")
  
  #Return the (now sanitised) original object
  return(x)
}