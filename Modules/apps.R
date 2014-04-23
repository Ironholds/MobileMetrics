#App-based data
apps <- function(x){
  
  #For each day/hour...
  app_data <- ddply(.data = x,
                    .variables = "timestamp",
                    .fun = function(x){
                      
                      #Count the number of hits to "our" app, and to all others
                      our_hits <- (sum(grepl(x = x$UA, pattern = "(WikipediaMobile|WikipediaApp|WiktionaryMobile)"))/nrow(x))*100
                      their_hits <- 100-our_hits
                      
                      #Count breakdown by OS
                      android <- (nrow(x[x$os == "Android",])/nrow(x))*100
                      iOS <- (nrow(x[x$os == "iOS",])/nrow(x))*100
                      unidentifiable <- (nrow(x[x$os == "Other",])/nrow(x))*100
                      other <- (nrow(x[!x$os %in% c("Android","iOS","Other"),])/nrow(x))*100
                      tablet <- (nrow(x[x$device %in% tablet_devices | x$os %in% tablet_os,])/nrow(x))*100
                      phone <- (nrow(x[x$device %in% mobile_devices | x$os %in% mobile_os,])/nrow(x))*100
                      unknown <- (nrow(x[!x$device %in% c(tablet_devices,mobile_devices) ]))
                      #Turn into a vector and return
                      return(c(our_hits,their_hits,android,iOS,unidentifiable,other))
                    })
  
  #Rename
  names(app_data) <- c("timestamp","Wikimedia","ExternalApps","android","iOS","unidentifiable","other","Tablet","Phone")
  
  #Split out, reshape and write
  FileWrite(x = melt(app_data[,c("timestamp","Wikimedia","ExternalApps"),], id.vars = 1, measure.vars = 2:3),
            filename = file.path(getwd(),"Output","apps_by_provider.tsv"))
  
  FileWrite(x = melt(app_data[,c("timestamp","android","iOS","unidentifiable","other"),], id.vars = 1, measure.vars = 2:5),
            filename = file.path(getwd(),"Output","apps_by_os.tsv"))

  FileWrite(x = melt(app_data[,c("timestamp","Tablet","Phone"), id.vars = 1, measure.vars = 2:3]),
            filename = file.path(getwd(),"Output","apps_by_device_class.tsv"))
  
  #Done
  return(invisible())
}