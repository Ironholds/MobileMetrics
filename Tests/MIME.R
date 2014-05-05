MIME_tests <- function(){
  
  #Retrieve data
  dispose <- system("hive -S -f ./Tests/HQL/desktop_mime.hql > ./Tests/Input/desktop_mime.tsv")
  dispose <- system("hive -S -f ./Tests/HQL/mobile_mime.hql > ./Tests/Input/mobile_mime.tsv")
  
  
}