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

#MIMEs for desktop
nonapp_MIMEs <- c("text/html; charset=UTF-8",
                    "text/html; charset=utf-8",
                    "text/html; charset=iso-8859-1",
                    "text/html; charset=ISO-8859-1",
                    "text/html")

#Actual projects
project_sources <- c("(mediawiki|((commons|meta|species)\\.(m\\.)?wikimedia)|(wik(tionary|isource|ibooks|ivoyage|iversity|iquote|inews|ipedia|idata)))")

#Internal sources of requests
internal_sources <- "(ForeignAPIRepo|Parsoid|MediaWiki(?!(Crawler| Bot))|Commons API)"

#Content sources
content_sources <- c("(/\\?title=|/wiki\\?curid=|/sr-ec/|/w/|/wiki/|/zh/|/zh-tw/|/zh-cn/|/zh-hant/|/zh-mo/|/zh-hans/|/zh-hk/|/sr/|/zh-sg/|/sr-hl/|/sr-el/)")

#Indicates the mobile website
mobile_web <- c("(\\.m\\.mediawiki|((commons|meta|species)\\.m\\.wikimedia)|\\.m\\.(wik(tionary|isource|ibooks|ivoyage|iversity|iquote|inews|ipedia|idata)))")

#Indicates particular mobile apps
mobile_apps <- c("(WikipediaMobile|iWiki|WikiEgg|Quickipedia(?!( bot))|Wikipanion|WiktionaryMobile|^Articles|Wikiweb|WikipediaApp|Wikiamo|WikiLinks)")

#Undesirable API requests
undesired_APIs <- c("(action=(feedrecentchanges|opensearch|ajax|compare)|prop=(pageimage|imageinfo&)|&sections=0|list=(allpages|recentchanges|categorymembers|search)|api\\.php$)")

#Columns we want to keep after tagging/logging/etc,etc,etc
desired_columns <- c("timestamp","URL","MIME","UA","x_analytics","device","os","browser","browser_version")

#mobile devices
mobile_devices <- c("iPhone","GT-I9300","GT-I9100","Generic Feature Phone","GT-I9505","HTC One",
                    "GT-I8190","Lumia 520","GT-N7100","SCH-I535","Nexus 5","SAMSUNG GT-I9505",
                    "Nexus 4","SPH-L710","GT-I9500","SAMSUNG-SGH-I337","C6603","GT-S5830i",
                    "SAMSUNG-SGH-I747","GT-I9195","GT-S5360","GT-I8190N","SCH-I545",
                    "Galaxy Nexus","SonySO-04E","C6903","GT-I8160","GT-I8190L",
                    "XT1032","DROID RAZR","BlackBerry 9320","Lumia 920", "GT-N7000",
                    "GT-S7562","XT907","SGH-T999","GT-I9305","BlackBerry 8520","SAMSUNG SCH-I545",
                    "SAMSUNG GT-I9500","SM-N9005","GT-I9105P","BlackBerry Touch","SC-06D","C5303",
                    "SC-04E","SAMSUNG SM-N9005","Lumia 800","SGH-I747M","SonySO-02E")

tablet_devices <- c("iPad","Nexus 7","Kindle Fire HD 7\" WiFi", "Kindle Fire HD", "Kindle Fire HDX 7\" WiFi",
                    "GT-P5110","GT-P3100","Kindle Fire","GT-N8000","GT-P5100")

mobile_os <- c("Firefox OS","Windows Phone","Windows Mobile")

tablet_os <- c("Windows RT", "Windows RT 8.1", "Blackberry Tablet OS")