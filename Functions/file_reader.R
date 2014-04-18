#Reads sample log files
file_reader <- function(file){
  
  #If the files somehow already exist, remove them
  if(file.exists("./Data/dailydata.tsv")){
    
    file.remove("./Data/dailydata.tsv")
  }
  if(file.exists("./Data/processeddata.tsv")){
    
    file.remove("./Data/processeddata.tsv")
  }
  
  #Move file into the current directory and unzip
  file.copy(from = file, to = file.path(getwd(),"Data","dailydata.tsv.gz"), overwrite = TRUE)
  system("gunzip ./Data/dailydata.tsv.gz")
  
  #Awk the hell out of it
  system("awk -f awkstrings ./Data/dailydata.tsv")
  
  #Read it in
  data.df <- read.delim(file = "./Data/processeddata.tsv", sep = "\t", header = FALSE, 
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
  file.remove(c("./Data/dailydata.tsv","./Data/processeddata.tsv"))
  
  #Return
  return(data.df)
}