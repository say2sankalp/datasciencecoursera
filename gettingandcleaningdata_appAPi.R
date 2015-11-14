rm(list = ls(all=TRUE))
library(httr)

##finding oauth id 
# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

###after doing all shitness formalties in sexy way 
# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.

myapp<- oauth_app("github",
                  key = "3f7391bae612cd906282",
                  secret = "5302c085fe6f758fceae2b4bfea2408724e85876")

github_token<- oauth2.0_token(oauth_endpoints("github"),myapp)

###after completing authentication 
github_token
gtoken<- config(token = github_token)

### ready for home timing 
hometm<- GET("https://api.github.com/users/jtleek/repos",gtoken)
stop_for_status(hometm)
json_content<- content(hometm)
library(jsonlite)
json_content2<- jsonlite::fromJSON(toJSON(json_content))
json_content2[json_content2$full_name=="jtleek/datasharing",]
