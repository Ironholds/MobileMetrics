#Tags and adds categories
tagger <- function(x, regex, values, start, end, name, ...){
  
  #Run the regex over X, generating a resultant boolean vector
  bools <- custodiet(x = x, regex = regex, start = start, end = end, name = name, ...)
  
  #Replace bools
  bools[bools == TRUE] <- values[1]
  bools[bools == FALSE] <- values[2]
  
  #Return
  return(bools)
}