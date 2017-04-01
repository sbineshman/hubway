library(httr)
library(jsonlite)
## 
## Attaching package: 'jsonlite'
## 
## The following object is masked from 'package:utils':
## 
##     View
install.packages('lubridate')
library(lubridate)

url  <- "https://api.darksky.net/forecast/ea9cb2e98b3016f998b9f9311328aba0/42.35154,-71.04573"
#path <- "ea9cb2e98b3016f998b9f9311328aba0/42.35154,-71.04573,2016-12-01 00:13:14"
#path <- "ea9cb2e98b3016f998b9f9311328aba0/42.35154,-71.04573"

raw.result <- GET(url = url)
raw.result
names(raw.result)

head(raw.result$content)
this.raw.content <- rawToChar(raw.result$content)
substr(this.raw.content, 1, 100)
this.content <- fromJSON(this.raw.content)

this.content.df <- do.call(what = "rbind", args = lapply(this.content, as.data.frame))
#[key]/[latitude],[longitude],[time]

42.35154
-71.04573

names(this.content[[1]])

