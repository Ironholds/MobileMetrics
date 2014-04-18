#App-based data
apps <- function(x){
  
  #For each day/hour...
  app_data <- ddply(.data = x,
                    .variables = "timestamp",
                    .fun = function(x){
                      
                      #Count the number of hits to "our" app, and to all others
                      our_hits <- (sum(grepl(x = x$UA, pattern = "(WikipediaMobile|WikipediaApp)"))/nrow(x))*100
                      their_hits <- 100-our_hits
                      
                      #Count breakdown by OS
                      android <- (nrow(x[x$os == "Android",])/nrow(x))*100
                      iOS <- (nrow(x[x$os == "iOS",])/nrow(x))*100
                      unidentifiable <- (nrow(x[x$os == "Other",])/nrow(x))*100
                      other <- (nrow(x[!x$os %in% c("Android","iOS","Other"),])/nrow(x))*100
                      
                      #Turn into a vector and return
                      return(c(our_hits,their_hits,android,iOS,unidentifiable,other))
                    })
  
  #Rename
  names(app_data) <- c("timestamp","Wikimedia","ExternalApps","android","iOS","unidentifiable","other")
  
  #Split out and reshape
  app_breakdown <- melt(app_data[,c("timestamp","Wikimedia","ExternalApps"),], id.vars = 1, measure.vars = 2:3)
  os_breakdown <- melt(app_data[,c("timestamp","android","iOS","unidentifiable","other"),], id.vars = 1, measure.vars = 2:5)
  
  #Write
  if(file.exists(file.path(getwd(),"Output","apps_by_provider.tsv"))){
    
    write.table(x = app_breakdown, file = file.path(getwd(),"Output","apps_by_provider.tsv"),
                append = TRUE, quote = TRUE, sep = "\t", row.names = FALSE, col.names = FALSE)
  } else {
    
    write.table(x = app_breakdown, file = file.path(getwd(),"Output","apps_by_provider.tsv"),
                append = FALSE, quote = TRUE, sep = "\t", row.names = FALSE, col.names = TRUE)
  }
  if(file.exists(file.path(getwd(),"Output","apps_by_os.tsv"))){
    
    write.table(x = os_breakdown, file = file.path(getwd(),"Output","apps_by_os.tsv"),
                append = TRUE, quote = TRUE, sep = "\t", row.names = FALSE, col.names = FALSE)
  } else {
    
    write.table(x = os_breakdown, file = file.path(getwd(),"Output","apps_by_os.tsv"),
                append = FALSE, quote = TRUE, sep = "\t", row.names = FALSE, col.names = TRUE)
  }
  
  return(invisible())
}