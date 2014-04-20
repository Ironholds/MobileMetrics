accepted_MIMES <- c("text/html; charset=UTF-8",
                    "text/html; charset=utf-8",
                    "text/html; charset=iso-8859-1",
                    "text/html; charset=ISO-8859-1",
                    "text/html",
                    "application/vnd.php.serialized; charset=utf-8",
                    "application/vnd.php.serialized; charset=UTF-8",
                    "application/vnd.php.serialized; charset=iso-8859-1",
                    "application/vnd.php.serialized; charset=ISO-8859-1",
                    "application/vnd.php.serialized",
                    "application/json; charset=utf-8",
                    "application/json; charset=UTF-8",
                    "application/json; charset=iso-8859-1",
                    "application/json; charset=ISO-8859-1",
                    "application/json",
                    "text/xml; charset=utf-8",
                    "text/xml; charset=UTF-8",
                    "text/xml; charset=iso-8859-1",
                    "text/xml; charset=ISO-8859-1",
                    "text/xml",
                    "application/x-www-form-urlencoded; charset=UTF-8",
                    "application/x-www-form-urlencoded; charset=utf-8",
                    "application/x-www-form-urlencoded; charset=iso-8859-1",
                    "application/x-www-form-urlencoded; charset=ISO-8859-1",
                    "application/x-www-form-urlencoded",
                    "application/xml; charset=UTF-8",
                    "application/xml; charset=utf-8",
                    "application/xml; charset=iso-8859-1",
                    "application/xml; charset=ISO-8859-1",
                    "application/xml",
                    "application/yaml; charset=utf-8",
                    "application/yaml; charset=UTF-8",
                    "application/yaml; charset=iso-8859-1",
                    "application/yaml; charset=ISO-8859-1",
                    "application/yaml")

#Actual projects
project_sources <- c("(mediawiki|((commons|meta|species)\\.(m\\.)?wikimedia)|(wik(tionary|isource|ibooks|ivoyage|iversity|iquote|inews|ipedia|idata)))")

#Internal sources of requests
internal_sources <- c("(ForeignAPIRepo|Parsoid|MediaWiki|Commons API)")

#Content sources
content_sources <- c("(/\\?title=|/wiki\\?curid=|/sr-ec/|/w/|/wiki/|/zh/|/zh-tw/|/zh-cn/|/zh-hant/|/zh-mo/|/zh-hans/|/zh-hk/|/sr/|/zh-sg/|/sr-hl/|/sr-el/)")

mobile_web <- c("(\\.m\\.mediawiki|((commons|meta|species)\\.m\\.wikimedia)|\\.m\\.(wik(tionary|isource|ibooks|ivoyage|iversity|iquote|inews|ipedia|idata)))")

mobile_apps <- c("(WikipediaMobile|iWiki|WikiEgg|Wikipanion|^Articles|Wikiweb|WikipediaApp|Wikiamo)")

desired_columns <- c("timestamp","URL","MIME","UA","x_analytics","device","os","browser","browser_version","browser_minor")
