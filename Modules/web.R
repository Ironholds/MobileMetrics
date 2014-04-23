web <- function(x){
  
  #For each day/hour...
  app_v_web <- ddply(.data = x,
                    .variables = "timestamp",
                    .fun = function(x){
                      
                      #Count the percentage of hits to the mobile site, excluding apps requests
                      mobile_site <- (nrow(x[x$site == "mobile" & x$method == "non-app",])/nrow(x))*100
                      
                      #Count the percentage of hits to apps
                      apps <- (nrow(x[x$method == "app",])/nrow(x))*100
                      
                      #OS breakdown for web
                      mnrow <- nrow(x[x$site == "mobile" & x$method == "non-app",])
                      android <- (nrow(x[x$site == "mobile" & x$method == "non-app" & x$os == "Android",])/mnrow)*100
                      iOS <- (nrow(x[x$site == "mobile" & x$method == "non-app" & x$os == "iOS",])/mnrow)*100
                      unidentifiable <- (nrow(x[x$site == "mobile" & x$method == "non-app" & x$os == "Other",])/mnrow)*100
                      other <- (nrow(x[x$site == "mobile" & x$method == "non-app" & !x$os %in% c("Android","iOS","Other"),])/mnrow)*100
                      
                      return(c(mobile_site,apps,android,iOS,unidentifiable,other))
                      
                    })
  
  names(app_v_web) <- c("timestamp","MobileSite","MobileApps","Android","iOS","unidentifiable","other")
  
  #Split out, reshape and write
  FileWrite(x = melt(app_v_web[,c("timestamp","MobileSite","MobileApps"),], id.vars = 1, measure.vars = 2:3),
            filename = file.path(getwd(),"Output","mobile_by_provider.tsv"))
  
  FileWrite(x = melt(app_v_web[,c("timestamp","android","iOS","unidentifiable","other"),], id.vars = 1, measure.vars = 2:5),
            filename = file.path(getwd(),"Output","mobile_by_provider.tsv"))

  return(invisible())
}