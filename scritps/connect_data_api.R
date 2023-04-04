#Connect to data using API

#library(tidyverse)
library(httr)
library(jsonlite) # if needing json format

cID<-"3846"      # client ID
secret<- "	 Og9anbBxiC9fx7TZkSv9huyxW09uzadzq7HDSTq4" # client secret
proj.slug<- "whelk-suction-dredge-survey" # project slug
form.ref<- "	5b74cfa6934a47bda5b402f0cd46b9e5_641c586069add" # form reference
branch.ref<- "YourFromRef+BranchExtension" # branch reference

res <- POST("https://five.epicollect.net/api/oauth/token",
            body = list(grant_type = "client_credentials",
                        client_id = cID,
                        client_secret = secret))
http_status(res)
token <- content(res)$access_token

# url.form<- paste("https://five.epicollect.net/api/export/entries/", proj.slug, "?map_index=0&form_ref=", form.ref, "&format=json", sep= "") ## if using json
url.form<- paste("https://five.epicollect.net/api/export/entries/", proj.slug, "?map_index=0&form_ref=", form.ref, "&format=csv&headers=true", sep= "")

res1<- GET(url.form, add_headers("Authorization" = paste("Bearer", token)))
http_status(res1)
# ct1<- fromJSON(rawToChar(content(res1))) ## if using json
ct1<- read.csv(res1$url)
str(ct1)

# url.branch<- paste("https://five.epicollect.net/api/export/entries/", proj.slug, "?map_index=0&branch_ref=", branch.ref, "&format=json&per_page=1000000", sep= "") ## if using json; pushing max number of records from default 50 to 10^6
url.branch<- paste("https://five.epicollect.net/api/export/entries/", proj.slug, "?map_index=0&branch_ref=", branch.ref, "&format=csv&headers=true", sep= "")

res2<- GET(url.branch, add_headers("Authorization" = paste("Bearer", token)))
http_status(res2)
ct2<- read.csv(res2$url)
# ct2<- fromJSON(rawToChar(content(res2))) ## if using json
str(ct2)
