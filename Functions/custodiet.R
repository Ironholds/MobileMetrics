#This. This watches the watchmen.
custodiet <- function(x, start, end, regex, name, ...){
  
  #Construct initial data frame
  output.df <- as.data.frame(substring(x,start,end))
  
  #Run the regex over the object
  output.df$reg_results <- grepl(x = x, pattern = regex, ...)
  
  #Randomly sample 10,000 rows.
  output.df <- output.df[sample(1:nrow(output.df), 10000),]
  
  #Rename
  names(output.df) <- c("substring","hit")
  
  #Write out
  write.table(x = output.df, file = file.path(getwd(),"Logs",curdate,paste(name,"log.tsv", sep = "_")),
              quote = TRUE, sep = "\t", row.names = FALSE)
  
  #Return the regex results
  return(output.df$hit)
}