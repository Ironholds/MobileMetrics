grapher <- function(data, title, file){
  
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
  
  png(filename = file.path(getwd(),"Output",paste(file,"monthly.png", sep = "_")),
      width = 1200, height = 781)
  ggplot(data = monthly_melted, aes(timestamp,value, group = variable)) + 
    geom_line(aes(colour = variable), size = 3) +
    scale_x_date(breaks = "month") +
    scale_y_continuous(labels = percent,
                       breaks = c(0.0,0.25,0.5,0.75,1),
                       limits = c(0,1),
                       expand = c(0,0)) +
    labs(title = title,
         x = "Month",
         y = "Percentage of pageviews") +
    theme(axis.text = element_text(size = rel(1.7), colour = "black"), axis.ticks = element_line(colour = "black"), 
          legend.key = element_rect(colour = "white"), panel.background = element_rect(fill = "white", 
          colour = NA), panel.border = element_rect(fill = NA, 
          colour = "grey50", size = 3), panel.grid.major = element_line(colour = "grey90", 
          size = 0.2), panel.grid.minor = element_line(colour = "grey98", 
          size = 0.5), strip.background = element_rect(fill = "grey80", 
          colour = "grey50"),
          title = element_text(size = rel(2)),
          legend.text = element_text(size = rel(1.5), vjust = 10),
          legend.title = element_blank(),
          legend.position = "bottom",
          legend.direction = "vertical",
          text = element_text(family = "Open Sans"))
  dev.off()
  
}