#Look, everyone ELSE is allowed to name something after an author.
manguel <- function(x){
  
  #Check output folder exists
  dir.create(file.path(getwd(),"Output"), showWarnings = FALSE)
  
  #Remove Spiders
  x <- x[!x$device == "Spider",]
  
  #Generate analysis. Excuse the horrific nature of the code - it's the most run-efficient thing for the job.
  analysis <- ddply(.data = x,
                .variables = "timestamp",
                .fun = summarise,
                `mobile hits` = length(UA[site == "mobile" & method == "non-app" & MIME %in% nonapp_MIMEs]) * 1000, #Traffic for the mobile site
                `desktop hits` = length(UA[site == "desktop" & method == "non-app" & MIME %in% nonapp_MIMEs]) * 1000, #Traffic for the desktop site
                `app hits` = length(UA[method == "app"])*1000, #Traffic for apps
                `tablet hits to mobile site` = length(UA[method == "non-app" & site == "mobile" & (os %in% tablet_os | device %in% tablet_devices)])*1000, #Traffic to the mobile site from 'tablet' devices
                `phone hits to mobile site` = length(UA[method == "non-app" & site == "mobile" & (os %in% mobile_os | device %in% mobile_devices)])*1000, #Traffic to the mobile site from 'phone' devices
                `tablet hits to desktop site` = length(UA[method == "non-app" & site == "desktop" & (os %in% tablet_os | device %in% tablet_devices)])*1000,  #Traffic to the desktop site from 'tablet' devices
                `phone hits to desktop site` = length(UA[method == "non-app" & site == "desktop" & (os %in% mobile_os | device %in% mobile_devices)])*1000,  #Traffic to the desktop site from 'phone' devices
                `iOS hits, apps` = length(UA[method == "app" & os == "iOS"]) * 1000,
                `Android hits, apps` = length(UA[method == "app" & os == "Android"]) * 1000,
                `Other hits, apps` = length(UA[method == "app" & !os %in% c("Android","iOS","Other")]) * 1000,
                `Unidentifiable hits, apps` = length(UA[method == "app" & os == "Other"]) * 1000,
                `iOS hits, phones` = length(UA[method == "non-app" & (os %in% mobile_os | device %in% mobile_devices) & os == "iOS"]) * 1000,
                `Android hits, phones` = length(UA[method == "non-app" & (os %in% mobile_os | device %in% mobile_devices) & os == "Android"]) * 1000,
                `Other hits, phones` = length(UA[method == "non-app" & (os %in% mobile_os | device %in% mobile_devices) & !os %in% c("Android","iOS","Other")]) * 1000,
                `Unidentifiable hits, phones` = length(UA[method == "non-app" & (os %in% mobile_os | device %in% mobile_devices) & os == "Other"]) * 1000,
                `iOS hits, tablets` = length(UA[method == "non-app" & (os %in% tablet_os | device %in% tablet_devices) & os == "iOS"]) * 1000,
                `Android hits, tablets` = length(UA[method == "non-app" & (os %in% tablet_os | device %in% tablet_devices) & os == "Android"]) * 1000,
                `Other hits, tablets` = length(UA[method == "non-app" & (os %in% tablet_os | device %in% tablet_devices) & !os %in% c("Android","iOS","Other")]) * 1000,
                `Unidentifiable hits, tablets` = length(UA[method == "non-app" & (os %in% tablet_os | device %in% tablet_devices) & os == "Other"]) * 1000)
  
  #Save analysis
  save(analysis, file = file.path(getwd(),"Output","output.RData"))
  
  #Pass into grapher, chunk by chunk
  #PV data
  pv_breakdown <- analysis[,1:4]
  pv_absolute <- rowSums(pv_breakdown[,2:4])
  pv_breakdown[,2:4] <- pv_breakdown[,2:4]/pv_absolute
  grapher(data = pv_breakdown,
          title = "Mean daily pageviews, per site",
          file = "pageviews")
  
  #mobile site hits
  hits_breakdown <- analysis[,c(1,5:8)]
  hits_breakdown[,2] <- (hits_breakdown[,2]/rowSums(hits_breakdown[,c(2,4)]))
  hits_breakdown[,3] <- (hits_breakdown[,3]/rowSums(hits_breakdown[,c(3,5)]))
  hits_breakdown <- hits_breakdown[,1:3]
  grapher(data = hits_breakdown,
          title = "Destination for phones versus tablets",
          file = "destination")
  
  #Breakdown by device
  device_breakdown <- analysis[,c(1,5:8)]
  device_absolute <- rowSums(device_breakdown[,2:5])
  device_breakdown[,2] <- (rowSums(device_breakdown[,c(2,4)])/device_absolute)
  device_breakdown[,3] <- (rowSums(device_breakdown[,c(3,5)])/device_absolute)
  device_breakdown <- device_breakdown[,1:3]
  names(device_breakdown) <- c("timestamp","tablet","phone")
  grapher(data = device_breakdown,
          title = "Mean daily pageviews, tablets versus phones",
          file = "device_pageviews")
  
  #OS, apps
  os_breakdown <- analysis[,c(1,9:12)]
  os_absolute <- rowSums(os_breakdown[,2:5])
  os_breakdown[,2:5] <- (os_breakdown[,2:5]/os_absolute)
  
  grapher(data = os_breakdown,
          title = "Operating system for apps",
          file = "app_os")
  
  #OS, phones
  phone_breakdown <- analysis[,c(1,13:16)]
  phone_absolute <- rowSums(phone_breakdown[,2:5])
  phone_breakdown[,2:5] <- (phone_breakdown[,2:5]/phone_absolute)
  
  grapher(data = phone_breakdown,
          title = "Operating system for mobile phones",
          file = "phone_os")
  
  #OS, tablets
  tablet_breakdown <- analysis[,c(1,17:20)]
  tablet_absolute <- rowSums(tablet_breakdown[,2:5])
  tablet_breakdown[,2:5] <- (tablet_breakdown[,2:5]/tablet_absolute)
  
  grapher(data = tablet_breakdown,
          title = "Operating system for tablets",
          file = "tablet_os")
  
  #Return invisibly
  return(invisible())
}