#Reads sample log files
file_reader <- function(file){

  #Open connection
  con <- gzfile(file, open = "r")
  
  #Read it in
  suppressWarnings({
    
    data.df <- read.delim(file = con, sep = "\t", header = FALSE, 
                          as.is = TRUE, quote = "",
                          col.names = c("squid","sequence_no",
                                        "timestamp", "servicetime",
                                        "IP", "status_code",
                                        "reply_size", "request_method",
                                        "URL", "squid_status",
                                        "MIME", "referer",
                                        "x_forwarded", "UA",
                                        "lang", "x_analytics"),
                          colClasses = c("character","numeric",
                                         "character","numeric",
                                         "character","character",
                                         "numeric","character",
                                         "character","character",
                                         "character","character",
                                         "character","character",
                                         "character","character"))
    
  })
  
  #Close connection
  close(con)
  
  #Return
  return(data.df)
}