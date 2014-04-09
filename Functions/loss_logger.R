#Logs loss rate after various types of filtering (and performs the filtering)
loss_logger <- function(x){
  
  #Construct vector to save
  loss_log <- character(10)
  names(loss_log) <- c("Total requests",
                       "UTF-8 requests",
                       "Production requests",
                       "Project requests"
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
  x <- x[grepl(pattern = "((commons|meta|species)\\.wikimedia|(wik(tionary|isource|ibooks|ivoyage|iversity|iquote|inews|ipedia))\\.org)",
               x = x$URL,
               ignore.case = TRUE),]
  
  #Log non-project loss
  loss_log[3] <- nrow(x)
  
  #Remove non-text/html,application hits
  x <- x[x$MIME %in% c("text/html; charset=UTF-8",
                       "text/html; charset=utf-8",
                       "text/html; charset=iso-8859-1",
                       "text/html",
                       "application/vnd.php.serialized; charset=utf-8",
                       "application/json; charset=utf-8",
                       "application/json",
                       "text/xml; charset=utf-8"
                       ),]
  
  #Log non-pageview loss
  loss_log[4] <- nrow(x)
  
              
                           
  [15] "text/xml; charset=utf-8"                         
  [16] "application/opensearchdescription+xml"           
  [17] "application/x-www-form-urlencoded"               
  [18] "application/xml; charset=UTF-8"                  
  [19] "application/ogg"                                 
  [20] "image/svg+xml"                                   
  [21] "text/html; charset=iso-8859-1"                   
  [22] "text/x-wiki; charset=UTF-8"                      
  [23] "application/xml; charset=utf-8"                  
  [24] "text/x-component"                                
  [25] "text/html"                                       
  [26] ""                                                
  [27] "image/tiff"                                      
  [28] "application/pdf"                                 
  [29] "audio/webm"                                      
  [30] "application/rsd+xml; charset=utf-8"              
  [31] "text/plain; charset=utf-8"                       
  [32] "audio/midi"                                      
  [33] "text/plain"                                      
  [34] "text/plain; charset=UTF-8"                       
  [35] "text/text; charset=utf-8"                        
  [36] "application/x-wiki"                              
  [37] "application/x-www-form-urlencoded; charset=utf-8"
  [38] "video/webm"                                      
  [39] "application/x-www-form-urlencoded; charset=UTF-8"
  [40] "application/yaml; charset=utf-8"                 
  [41] "application/xml"                                 
  [42] "image/vnd.djvu"                                  
  [43] "audio/x-flac"                                    
  [44] "audio/x-wav"                                     
  [45] "application/x-www-form-urlencoded;charset=utf-8" 
  [46] "; charset=\\x22utf-8\\x22"                       
  [47] "unknown/unknown"                                 
  [48] "html"                                            
  [49] "application/octet-stream"                        
  
  #Exclude non-completed requests
  x <- x[grepl()]
  
  #Write out the metadata
  
  #Return
  return(x)
}