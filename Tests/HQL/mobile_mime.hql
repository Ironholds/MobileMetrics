set hive.mapred.mode = nonstrict;
ADD JAR /usr/lib/hcatalog/share/hcatalog/hcatalog-core-0.5.0-cdh4.3.1.jar;
SELECT *
FROM (SELECT url_host,url_path,url_query,content_type FROM webrequest_mobile
    WHERE year = 2014
	  AND month = 4
	  ORDER BY rand()) wmrand
LIMIT 5000000;