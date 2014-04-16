ua_parse <- function(x, data = c("device","os","browser","browser_version","browser_minor")){
  
  #Convert UAs into a JSON object and write out
  cat(toJSON(x = x$UA), file = "user_agent_input.json")
  
  #Call the Python script over them.
  system("python ./Functions/pyparse.py")
  
  #Read the results in
  returned_UAs <- fromJSON("user_agent_output.json")
  
  #Handle NULLs
  returned_UAs <- lapply(returned_UAs, function(x){
    
    for(i in seq_along(x)){
      
      if(is.null(x[[i]]) == TRUE){
        
        x[[i]] <- "Other"
      }
    }
    
    return(x)
  })
  
  #Convert into a data frame
  UAs.df <- data.frame(matrix(unlist(returned_UAs), nrow = length(returned_UAs), byrow = TRUE), stringsAsFactors = FALSE)
  
  #Rename
  names(UAs.df) <- names(returned_UAs[[1]])
  
  #What columns to keep?
  UAs.df <- UAs.df[,data]
  
  #Kill now-unwanted data files
  file.remove("user_agent_input.json","user_agent_output.json")
  
  #Bind into x
  x <- cbind(x,UAs.df)
  
  #Return
  return(x)
}
