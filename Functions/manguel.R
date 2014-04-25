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
                `tablet hits to mobile site` = length(UA[method == "non-app" & site == "mobile" & os %in% tablet_os | device %in% tablet_devices])*1000, #Traffic to the mobile site from 'tablet' devices
                `phone hits to mobile site` = length(UA[method == "non-app" & site == "mobile" & os %in% mobile_os | device %in% mobile_devices])*1000, #Traffic to the mobile site from 'phone' devices
                `tablet hits to desktop site` = length(UA[method == "non-app" & site == "desktop" & os %in% tablet_os | device %in% tablet_devices])*1000,  #Traffic to the desktop site from 'tablet' devices
                `phone hits to desktop site` = length(UA[method == "non-app" & site == "desktop" & os %in% mobile_os | device %in% mobile_devices])*1000,  #Traffic to the desktop site from 'phone' devices
                `iOS hits, apps` = length(UA[method == "app" & os == "iOS"]) * 1000,
                `Android hits, apps` = length(UA[method == "app" & os == "Android"]) * 1000,
                `Other hits, apps` = length(UA[method == "app" & !os %in% c("Android","iOS")]) * 1000,
                `Unidentifiable hits, apps` = length(UA[method == "app" & os == "Other"]) * 1000,
                `iOS hits, phones` = length(UA[method == "non-app" & (os %in% mobile_os | device %in% mobile_devices) & os == "iOS"]) * 1000,
                `Android hits, phones` = length(UA[method == "non-app" & (os %in% mobile_os | device %in% mobile_devices) & os == "Android"]) * 1000,
                `Other hits, phones` = length(UA[method == "non-app" & (os %in% mobile_os | device %in% mobile_devices) & !os %in% c("Android","iOS")]) * 1000,
                `Unidentifiable hits, phones` = length(UA[method == "non-app" & (os %in% mobile_os | device %in% mobile_devices) & os == "Other"]) * 1000,
                `iOS hits, tablets` = length(UA[method == "non-app" & (os %in% tablet_os | device %in% tablet_devices) & os == "iOS"]) * 1000,
                `Android hits, tablets` = length(UA[method == "non-app" & (os %in% tablet_os | device %in% tablet_devices) & os == "Android"]) * 1000,
                `Other hits, tablets` = length(UA[method == "non-app" & (os %in% tablet_os | device %in% tablet_devices) & !os %in% c("Android","iOS")]) * 1000,
                `Unidentifiable hits, tablets` = length(UA[method == "non-app" & (os %in% tablet_os | device %in% tablet_devices) & os == "Other"]) * 1000)
  
  #Load modules
  ignore <- lapply(list.files(file.path(getwd(),"Modules"),
                              pattern = "*.R", recursive = TRUE, full.names = TRUE),source)
  
  
  #Data on apps usage
  apps(x[x$method == "app",])
  
  #Data on comparative web usage
  web(x[x$method == "app" | x$site == "mobile",])
  
  #Data on comparative tablet/phone destinations
  tablet(x[x$os %in% c(mobile_os,tablet_os) | x$device %in% c(tablet_devices,mobile_devices),])
  
  #Return invisibly
  return(invisible())
}