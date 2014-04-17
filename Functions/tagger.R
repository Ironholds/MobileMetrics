#Tags and adds categories
tagger <- function(x, regex, values,...){
  
  #Run the regex over X, generating a resultant boolean vector
  bools <- grepl(x = x, pattern = regex, ...)
  
  #Replace bools
  bools[TRUE] <- values[1]
  bools[FALSE] <- values[2]
  
  #Return
  return(bools)
}