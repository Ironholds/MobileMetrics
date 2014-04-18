#Tags requests, logging the result
tag_logger <- function(x){
  
  tag_log <- numeric(3)
  names(tag_log) <- c("mobile site hits",
                      "App hits",
                      "Zero hits")
  
  #Mobile site or desktop site?
  x$site <- tagger(x = x$URL, regex = mobile_web, values = c("mobile","desktop"), start = 1, end = 30, name = "site")
  tag_log[1] <- nrow(x[x$site == "mobile",])
  
  #App or non-App?
  x$method <- tagger(x = x$UA, regex = mobile_apps, values = c("app","non-app"), start = 1, end = 30, name = "app")
  tag_log[2] <- nrow(x[x$method == "app",])
  
  #Zero or non-zero?
  x$zero <- tagger(x = x$x_analytics, regex = "zero", values = c("zero","non-zero"), start = 1, end = 30, name = "zero")
  tag_log[3] <- nrow(x[x$zero == "zero",])
  
  #Write tag log
  write.table(x = tag_log,
              file = file.path(getwd(),"Logs",curdate,"tag_log.tsv"),
              quote = TRUE,
              sep = "\t")
  
  #Done
  return(x)
}