grapher <- function(data, title, file, is.percent = FALSE){
  
  data$timestamp <- as.Date(data$timestamp)
  
  #Monthly graphing - round timestamps, colmeans, melt.
  monthly <- data
  monthly$timestamp <- as.Date(paste(substr(monthly$timestamp, 1,7),"01",sep = "-"))
  
  monthly <- ddply(.data = monthly,
                   .variables = "timestamp",
                   .fun = function(x){
                     return(colMeans(x[,2:length(x)]))
                     }
                   )
  
  monthly_melted <- melt(data = monthly, id.vars = 1, measure.vars = 2:length(data))
  
  #Graph
  monthly_graph <- ggplot(data = monthly_melted, aes(timestamp,value, group = variable)) + 
    geom_line(aes(colour = variable)) +
    scale_x_date(breaks = "month") +
    labs(title = title,
         x = "Month",
         y = "Pageviews")
  
  if(is.percent){
    
    monthly_graph <- monthly_graph + scale_y_continuous(labels = percent)
    
  }
  #Save
  ggsave(filename = file.path(getwd(),"Output",paste(file,"monthly.png",sep = "_")),
         plot = monthly_graph)
  
}