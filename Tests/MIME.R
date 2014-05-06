MIME_tests <- function(){
  
  #Libraries
  library(plyr)
  library(ggplot2)
  
  #Retrieve data
  dispose <- system("hive -S -f ./Tests/HQL/desktop_mime.hql > ./Tests/Input/desktop_mime.tsv")
  dispose <- system("hive -S -f ./Tests/HQL/mobile_mime.hql > ./Tests/Input/mobile_mime.tsv")
  
  #Read it in
  data <- lapply(c("desktop.mime.tsv","mobile_mime.tsv"),{
    
    #Read
    part_data <- read.delim(file.path(getwd(),"Tests","Input",x), as.is = TRUE, header = TRUE)
    
    #Mark
    if(grepl(x = x, pattern = "mobile")){
      
      part_data$type <- "mobile"
    } else {
      
      part_data$type <- "desktop"
      
    }
    
    #Paste URL fragments together
    part_data$url <- paste(part_data$url_host, part_data$url_path, part_data$url_query, sep = "")
    
    #Return
    return(part_data[,c("url,content_type,type")])
  })
  
  #Bind
  data <- do.call("rbind",data)
  
  #Graph
  
  #Sample 100 observations from each, where available, or all if <100
  sampled_data <- ddply(.data = data,
                        .variables = ("content_type","type"),
                        .fun = function(x){
                          
                          if(nrow(x) >= 100){
                            
                            return(x[sample(1:nrow(x), size = 100),])
                            
                          } else {
                            
                            return(x)
                          }
                        })
  
  #Save to file for hand-coding
}