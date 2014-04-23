#Look, everyone ELSE is allowed to name something after an author.
manguel <- function(x){
  
  #Check output folder exists
  dir.create(file.path(getwd(),"Output"), showWarnings = FALSE)
  
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