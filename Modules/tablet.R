tablet <- function(x){
  
  tablet_data <- ddply(.data = x,
                       .variables = "timestamp",
                       .fun = function(x){
                         
                         #Hits
                         tablet_hits <- nrow(x[x$os %in% tablet_os | x$device %in% tablet_devices,])
                         mobile_hits <- nrow(x[x$os %in% mobile_os | x$device %in% mobile_devices,])
                         
                         #Device breakdown
                         tablet_percent <- (tablet_hits/(tablet_hits+mobile_hits))*100
                         mobile_percent <- (mobile_hits/(tablet_hits+mobile_hits))*100
                         
                         #Per-device destination
                         tablets <- (nrow(x[x$os %in% tablet_os & x$site == "mobile" | x$device %in% tablet_devices & x$site == "mobile",])/tablet_hits)*100
                         mobile <- (nrow(x[x$os %in% mobile_os & x$site == "mobile" | x$device %in% mobile_devices & x$site == "mobile",])/tablet_hits)*100
                                                  
                         return(c(tablet_percent,mobile_percent,tablets,mobile))
                       })
  
  names(tablet_data) <- c("timestamp","tablets","phones","tablet","phone")
  
  #Split out, reshape and write
  FileWrite(x = melt(tablet_data[,c("timestamp","tablets","phones"),], id.vars = 1, measure.vars = 2:3),
            filename = file.path(getwd(),"Output","phones_versus_tablets.tsv"))
  FileWrite(x = melt(tablet_data[,c("timestamp","tablet","phone"),], id.vars = 1, measure.vars = 2:3),
            filename = file.path(getwd(),"Output","mobile_by_destination.tsv"))
}