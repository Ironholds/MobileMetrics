ua_parse <- function(uas, data = c("device","os","browser","browser_version")){
  
  #Strip unwanted characters
  uas <- gsub(x = uas, pattern = "(\x1f)", replacement = "")
  
  #Convert UAs into a JSON object and write out
  cat(toJSON(x = uas, .escapeEscapes = FALSE), file = "user_agent_input.json")
  
  #Call the Python script over them.
  system("python pyparse.py")
  
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
  
  #Return
  return(UAs.df)
}
