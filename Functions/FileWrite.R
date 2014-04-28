FileWrite <- function(x, ids, measures, filename){
  
  if(file.exists(filename)){
    
    
    write.table(x = x, file = filename,
                append = TRUE, quote = TRUE, sep = "\t", row.names = FALSE, col.names = FALSE)
  } else {
    
    write.table(x = x, file = filename,
                append = FALSE, quote = TRUE, sep = "\t", row.names = FALSE, col.names = TRUE)
  }
  
  return(invisible())
  
}