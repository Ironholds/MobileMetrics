#Look, everyone ELSE is allowed to name something after an author.
manguel <- function(x){
  
  #Check output folder exists
  dir.create(file.path(getwd(),"Output"), showWarnings = FALSE)
  
  #Load modules
  ignore <- lapply(list.files(file.path(getwd(),"Modules"),
                              pattern = "*.R", recursive = TRUE),source)
  
  #App data
  apps(x[x$method == "app",])
  
  #Web data
  web(x[x$method == "app" | x$site == "mobile",])
  
  #Return invisibly
  return(invisible())
}