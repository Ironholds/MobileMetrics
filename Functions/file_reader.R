#Reads sample log files
file_reader <- function(file){
  
  #Move file into the current directory and unzip
  system(paste("cp ",file,file.path(getwd(),"dailydata.tsv.gz")))
  system("gunzip dailydata.tsv.gz")
  
  #Awk the hell out of it
  system("awk -f awkstrings dailydata.tsv")
  
  #Read it in
  data.df <- read.delim(file = "processeddata.tsv", sep = "\t", header = FALSE, 
                        as.is = TRUE, quote = "",
                        col.names = c("squid","sequence_no",
                                      "timestamp", "servicetime",
                                      "IP", "status_code",
                                      "reply_size", "request_method",
                                      "URL", "squid_status",
                                      "MIME", "referer",
                                      "x_forwarded", "UA",
                                      "lang", "x_analytics"),
                        colClasses = c("character","character",
                                       "character","character",
                                       "character","character",
                                       "character","character",
                                       "character","character",
                                       "character","character",
                                       "character","character",
                                       "character","character"))
  
  #Remove the original files
  file.remove(c("dailydata.tsv","processeddata.tsv")
  
  #Return
  return(data.df)
}