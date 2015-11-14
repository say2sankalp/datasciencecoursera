rm(list = ls(all=TRUE))
getwd()

######creating ditextory 
if (!file.exists("data")) {
  dir.create("data")
  
}

###downloading fiel 
#download.file()
fileurl<- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?acessType=DOWNLOAD"
download.file(fileurl,destfile = "./data/cameras.csv")
list.files("./data")
datedownload<- date()
datedownload
camera<- read.table("./data/cameras.csv",sep = ",",header = TRUE)
#changing the above one 
head(camera)
# or we can use csv argument 
#######follwojng qare aargument to read the data 

if (!file.exists("data1")) { dir.create("data1")
  
}

fileurl1<- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileurl1,destfile = "./data1/cameras")
datedownload1<- date()
datedownload1
library(xlsx)
library(rJava)
##to know wat type of package are rquired 
require(xlsx)
#########it worked just do thsi 
#### Sys.setenv(JAVA_HOME='C:/Program Files/Java/jre1.8.0_65') 
#cameradata<- read.xlsx()


#######xml file 
library(XML)
fileurl2<-"http://www.w3schools.com/xml/simple.xml"
doc<- xmlTreeParse(fileurl2,useInternal =TRUE)
rootnode<- xmlRoot(doc)
xmlName(rootnode)
names(rootnode)
rootnode[[2]]
rootnode[[1]][[1]]
rootnode[[1]][[2]]
         xmlSApply(rootnode,xmlValue)
         xpathApply(rootnode,"//name",xmlValue)
         xpathApply(rootnode,"//price",xmlValue)
         
fileurl3<- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc<- htmlTreeParse(fileurl3,useInternal=TRUE)
scores<- xpathSApply(doc,"//li[@class='score']",xmlValue)
teams<- xpathSApply(doc,"//li[@class='team-name']",xmlValue)
scores
doc

##########json format reading 
library(jsonlite)
jsonData<- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
jsonData$owner$login
jsonData$name
myjson<- toJSON(iris,pretty = TRUE)
cat(myjson)
iris2<- fromJSON(myjson)
head(iris2)


##data.atable package

library(data.table)
DF=data.frame(x=rnorm(9),y=rep(c("a","b","c"),each=3 ),z=rnorm(9))
head(DF,3)

#data table 


DT<- data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
DT
tables()
#######subsetting the data table 

DT[2,]
DT[[1]]
DT[[2]]
DT[[1]][[2]]
DT[DT$y=="a"]
DT[,c(2,3)]
 
{
x=1
y=2

}
k={print(10);5}
print(k)
DT[,list(mean(x),sum(z))]
DT[,table(y)]
DT[,w:=z^2]
DT
DT[,m:={tmp<- x+z;log2(tmp+5)}]
DT
DT[,a:= x>0]
#PLYR like operation
DT[,b:=mean(x+w),by=a]
DT
set.seed(123)
DT<- data.table(x=sample(letters[1:3],1E5,TRUE))
DT[,.N,by=x]                
#SETTING KEY
DT<- data.table(x=rep(c("a","b","c"),each=100),y=rnorm(100))
setkey(DT,x)
DT['a']

DT1<- data.table(x=c("a","a","b","dt1"),y=1:4)
DT2<- data.table(x=c("a","b","dt2"),z=5:7)
setkey(DT1,x)
setkey(DT2,x)
merge(DT1,DT2)

## noting the time by using each argument 
system.time()

#######installing mysql package ready for week 2
#install.packages("RMySQL")
library(RMySQL)
library(dbConnect)
library(DBI)
ucscDb<- dbConnect(MySQL(),user="genome",host="genome-mysql.cse.ucsc.edu" )
result<- dbGetQuery(ucscDb,"show databases");dbDisconnect(ucscDb)
result
Sys.getenv("R_USER")
#? Startup
# way of connecting to database 
hg19<- dbConnect(MySQL(),user="genome",db="hg19",host="genome-mysql.cse.ucsc.edu")
alltables<- dbListTables(hg19)
alltables
str(alltables)
length(alltables)
alltables[1:5]
#listing feilds in that database
dbListFields(hg19,"affyU133Plus2" )
dbGetQuery(hg19,"select count(*) from affyU133Plus2")
# reading table form that database 
affydata<- dbReadTable(hg19,"affyU133Plus2")
head(affydata )
query<- dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")
affymis<- fetch(query)
quantile(affymis$misMatches)

affymissmall<- fetch(query,n=10)
dbClearResult(query)
affymissmall
dim(affymissmall)
dbDisconnect(hg19)
H5close()
#####reading hdf5 file 
#source is used to read and execute the file
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)
created<- h5createFile("example.h5")
created
created<- h5createGroup("example.h5","foo")
created<- h5createGroup("example.h5","baar")
created<- h5createGroup("example.h5","foo/foobaaar")
h5ls("example.h5")

#Filling the value
a<- matrix(1:10,nrow = 5,ncol = 2)
h5write(a,"example.h5","foo/a")
b<- array(seq(0.1,0.2,by=0.1),dim = c(5,2,2))
attr(b,"scale")<- "liter"
h5write(b,"example.h5","foo/foobaaar/b")
h5ls("example.h5")

########writing a data frame
df<- data.frame(1L:5L,seq(0,1,length.out = 5),c("ab","cde","fgi","a","s"),stringsAsFactors = FALSE)
df
H5close()
h5write(df,"example.h5","df")
h5ls("example.h5")
readA<- h5read("example.h5","foo/a")
readB<- h5read("example.h5","foo/foobaaar/b")
readF<- h5read("example.h5","df")
readA
h5write(c(12,13,14),"example.h5","foo/a",index=list(1:3,1))
h5read("example.h5","foo/a")

##### web scraping 
conurl<- url("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlcode<- readLines(conurl)
close(conurl)
htmlcode
class(htmlcode)
length(htmlcode)


## second method 
library(XML)
conurll<- url("http://scholar.google.com/citations?user=HI-I6C0AAAJ&hl=en")
download.file(conurll,destfile = "conexp.xml")
html<- htmlTreeParse(conurll,useInternalNodes = T)
xpathSApply(html,"//title",xmlValue)

#####using httr and get commnad
library(httr)
html2<- GET(conurll)
content2<- content(html2,as = "text")
parsedHTML<- htmlParse(content2,asText = T)
xpathSApply(parsedHTML,"//title",xmlValue)

## navigating page with user and passwd
pg1<- GET("https://httpbin.org/basic-auth/user/passwd")
pg1
pg2<- GET("http://httpbin.org/basic-auth/user/passwd",authenticate("user","passwd"))
pg2

names(pg2)
pg2$cookies$domain
pg2$handle

###working on google 
google<- GET("http://google.com")
pg1<- GET(handle = google,path="/")
pg2<- GET(handle = google,path="search")
pg1


#######working on api

twitterapp<- oauth_app("twitter",key ="3Kb7QIYZhbv6YxJARTCyxuNXw",secret = "2vjJAg1rOkHXnTxb3NwlAY7sJqt4enpVDRAkIdkiDiF4CaAjMt" )
sig<- sign_oauth1.0(twitterapp,token = "3706398022-XjT5o6PlJsQs53PP6GzaDDpfgnVzgbUKusAsjPJ",token_secret = "wOgQhpzvGPNRXwZ4AwJ274oEBwpMoUhvPyc2slKCbsaV2")
homeTL<- GET("https://api.twitter.com/1.1/statuses/home_timeline.json",sig)
json1<- content(homeTL)
library(jsonlite)
json2<- jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]
###  you can rraad more at dev.twitter

##week3 begins 


