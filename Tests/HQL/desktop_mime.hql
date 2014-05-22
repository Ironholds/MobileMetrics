set hive.mapred.mode = nonstrict;
ADD JAR /usr/lib/hcatalog/share/hcatalog/hcatalog-core-0.5.0-cdh4.3.1.jar;
SELECT *
  FROM (SELECT uri_host,uri_path,uri_query,content_type FROM webrequest
        WHERE year = 2014
        AND month = 4
        AND webrequest_source = 'text'
        ORDER BY rand()) wmrand
LIMIT 5000000;