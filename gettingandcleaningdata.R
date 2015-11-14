rm(list = ls(all=TRUE))
getwd()
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileurl,destfile = "./data/q1.csv")
fil<- read.csv("./data/q1.csv")
str(fil)
ques1<- fil[fil$VAL== 24,]
str(ques1)
nrow(ques1)
View(ques1)
head(fil)
########question to answer 1 whwre it says how many houses are above 100000 
sum(!is.na(fil[fil$VAL >= 24, 37]))
######or second following method 
length(fil$VAL[(!is.na(fil$VAL)& fil$VAL== 24)])
system.time(ques1)
##### is na experiment 
test<-c(NA, NA,NA, 1,2,3,4)
mean(test)
mean(test,na.rm = TRUE)
#######is na will produce logical results 000111 avg 4/7 or 3/7 u gt it ,i think 
mean(is.na(test))
mean(!is.na(test))
mean(na.omit(test))
test

######### ques 3 reading xml 
url3<- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc<- xmlTreeParse(url3,useInternal=TRUE)
rootnode<- xmlRoot(doc)
rootnode
xmlApply(rootnode,xmlValue)
sum(xpathSApply(rootnode,"//zipcode",xmlValue)=="21231")


######method 2 for reading xml file 
if(!file.exists("data")){
  dir.create("data")
}
fileurl2<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileurl2,destfile = "./data/restaurent.xml")
datedownload<-date()

doc<- xmlTreeParse("./data/restaurent.xml",useInternal=T)
rootnode<- xmlRoot(doc)
doc
rootnode
## above two are same 
name_rowid<- xpathSApply(rootnode,"//name",xmlValue)
length(name_rowid)
head(name_rowid)
tail(name_rowid)
name_rowid[1:50]
neighbour<- xpathSApply(rootnode,"//neighborhood",xmlValue)
neighbour[1:40]
mydf<- data.frame()
mydf<- cbind(neighbour,name_rowid)
mydf
write.csv(mydf,"restaurentlist.csv",row.names = TRUE)
dim(mydf)

zcode<- xpathSApply(rootnode,"//zipcode",xmlValue)
rm(contaniner)
length(zcode)
class(zcode)
length(zcode[zcode=="21231"])
length(zcode[zcode==21231])

sum(zcode == "21231")
sum(xpathSApply(rootnode,"//zipcode",xmlValue)=="21231")
###########ansqwwer in one more basic way most fundamnetal way 
names(rootnode)
rootnode[[1]][1]
rootnode[[1]][[1]]
rootnode[[1]][[2]]
zipcode<- xpathSApply(rootnode,"//zipcode",xmlValue)
zipcode
length(zipcode[zipcode=="21231"])
       
sapply("//titles", xmlValue)
######quest 5 measuring time by using various argument 

if(!dir.exists("data"))
   {
  dir.create("data3")
}
list.dirs()

filerl3<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(filerl3,destfile = "./data3/idahohouse.csv")
datedownloaded<- date()

DT<- fread("./data3/idahohouse.csv")
str(DT)
dim(DT)
##########measuring the time 
head(DT)
sapply(split(DT$pwgtp15,DT$SEX),mean)
mean(DT$pwgtp15,by=DT$SEX)
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
tapply(DT$pwgtp15,DT$SEX,mean)
system.time(sapply(split(DT$pwgtp15,DT$SEX), mean))
system.time(mean(DT$pwgtp15,by= DT$SEX))
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(mean(DT[DT$SEX==1,]$pwgtp15))
system.time(mean(DT[DT$SEX==2,]$pwgtp15))
system.time(tapply(DT$pwgtp15, DT$SEX, mean))


###quiz 2
library(sqldf)
if(!dir.exists("coursera_quiz")){
  dir.create("coursera_quiz")
}

list.dirs("./")
getwd()
qurl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(qurl,destfile = "./q.csv")



acs<- read.csv("./q.csv")
library(data.table)
acs<- data.table(acs)
query1<- sqldf("Select pwgtp1 from acs") 
query2<- sqldf("select * from acs where AGEP <50")
query3<- sqldf("select pwgtp1 from acs where AGEP <50 ")
query4<- sqldf("select * from acs where AGEP <50 and pwgtp1")
query4
query3

## question 2
u<- unique(acs$AGEP)
sqldf("select AGEP where unique from acs")##error syntaqx
sqldf("select distinct AGEP from acs")

###question 3 
q4url<- url("http://biostat.jhsph.edu/~jleek/contact.html")
download.file(q4url,destfile = "./contact.html")
htmlcode<- readLines(q4url)
close(q4url)
htmlcode
x<- c(htmlcode[10],htmlcode[20],htmlcode[30],htmlcode[100])
nchar(x)
###below also gives same answer  as above 
x1<- htmlcode[c(10,20,30,100)]
nchar(x1)

##fixed width file quiz
q5_url<- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(q5_url,destfile = "./q5.csv")
dcsv<- read.csv("./q5.csv")
head(dcsv)
