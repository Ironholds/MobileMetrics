library(plyr)

#Compresses the custodiet logs to allow for easier parsing, checking and hand-coding.
LogChecker <- function(){
  
  #Read file type
  file_type <- readline("File Type: \n")
  
  #List files
  file_list <- list.files(path = file.path(getwd(),"Logs"), pattern = file_type,
                          full.names = TRUE, recursive = TRUE)
  
  #Read them in.
  data <- lapply(file_list,read.delim, as.is = TRUE, header = TRUE)
  
  #Format into a single df
  data <- do.call("rbind",data)
  
  #Remove dupes but keep count
  data <- ddply(.data = data,
                .variables = "substring",
                .fun = function(x){as.data.frame(table(x$hit), stringsAsFactors = FALSE)})
  
  #Reorder
  data <- data[order(data$Var1,data$Freq, decreasing = TRUE),]
  
  #Return
  return(data)
}