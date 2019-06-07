# getting and cleaning data 
# day1

# checking for and creating directories 

# file.exists("directoryname") : will check to see if the directory exists
# dir.create("directoryname") : will create a directory if it doesn't exist

# example 
getwd()
setwd("C:/Users/sangdon/Desktop/datasciencecoursera/getting and cleaning data")

file.exists("data")
if (!file.exists("data")) { # data 파일이 없다면
        dir.create("data")  # 만들어라
}

file.exists("data") # TRUE


# getting data from the internet

# download.file()

# important parameters are url, destfile, method
# used for downloading tab-delimited, csv, and other files

# 링크버튼에서 마우스 오른쪽 클릭 - 링크 주소 복사 클릭 

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"

# destfile : ./파일명/파일형식 입력
# method : mac의 경우 http 사이트는 보안 때문에 curl을 명시해주어야함. window는 default이므로 명시 안해도 무방
# 파일이 크면 시간이 많이 걸릴 수 있음. 
# 언제 다운로드 했는지 확실히 기록할 필요가 있음. 
download.file(fileUrl, destfile = "./data/cameras.csv", method = "curl") 
list.files("./data")
dateDownloaded
dateDownloaded <- date()
dateDownloaded

# loading flat files - read.table()

cameraData <- read.table("./data/cameras.csv")

head(cameraData)


# csv파일에 read.table 함수를 쓸 경우 sep를 구분해주어야함
cameraData <- read.table("./data/cameras.csv", sep = ",", header = T) 
head(cameraData)


# read.csv sets sep="," and header=T
cameraData <- read.csv("./data/cameras.csv")
head(cameraData)


# read.table some more important parameters

# quote : 기본값은 큰따옴표(")로 각 열을 감싸는 문자 지정. 감싸는 문자 안에 있는 열 구분기호는 읽어들일 자료로 인식
# EOF within quoted string 에러가 뜰 경우 quote = ""로 해결 

# na.strings : 어떤 값이 missing value로 대표되는지. ex) na.strings=c("a", "b", "c")

# download the file to load 
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD&bom=true&format=true"
download.file(fileUrl, destfile = "./data/cameras.xlsx", method="curl")
dateDownloaded <- date()

library(xlsx)
cameraData <- read.xlsx("./data/cameras.xlsx", sheetIndex = 1, header = T)
readxl::read_xlsx("./data/cameras.xlsx", col_names = T, sheet = 1)

# 원하는 범위만큼 subset 가능
colIndex <- 2:3
rowIndex <- 1:4
cameraData <- read.xlsx("./data/cameras.xlsx", sheetIndex = 1, colIndex = colIndex, rowIndex = rowIndex)

# read.xlsx2 : read.xlsx 보다 빠르지만 행을 subset 해서 추출할 때는 덜 유연함



# reading XML
# components 
# - markup : labels that give the text structure
# - content : the actual text of the document 

# tags, elements and attribute 

# tag correspond to general labels
# - start tag : <section>
# - end tag : </section>
# - empty tag : <line-break />

# elements are specific example of tags 
# - <Greeting> Hello, world </Greeting>

# Attribute are component of the label 
# - <img src="jeff.jpg" alt="instructor"/>
# - <step number="3"> Connect A to B. </step>


library(XML)
fileUrl <- "https://www.w3schools.com/xml/simple.xml"
xml <-"./data/q4_dat.xml"
download.file(fileUrl, xml, quiet = TRUE)
dat_xml<-xmlInternalTreeParse(xml)
topNode<-xmlRoot(dat_xml) # obtain access to the top node

class(topNode)
xmlName(topNode)
names(topNode)

topNode[[1]]
topNode[[1]][[1]]

xmlSApply(topNode, xmlValue)



# XPath
# /node TOP level node
# //node Node at any level
# node[@attr-name] Node with an attribute name
# node[@attr-name='bob'] Node with attribute name attr-name='bob'

xpathSApply(topNode, "//name", xmlValue)
xpathSApply(topNode, "//price", xmlValue)


fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl,useInternal=TRUE)
teams <- xpathSApply(doc,"//li[@class='team-name']",xmlValue)
teams   

################################################################################################
# day2 

# json 포맷 불러오기

library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)

names(jsonData$owner)
jsonData$owner$login


jsonData[1:3, ]$owner$login
jsonData[1:3, "owner"]$login
jsonData$owner[1:3, "login"]
jsonData$owner[1:3, ]$login


# 데이터 프레임을 JSON 파일로 바꾸기 
myjson <- toJSON(iris, pretty = T) # pretty = T : 들여쓰기 유무 

iris2 <- fromJSON(myjson)
head(iris2)


# data.table 패키지 

library(data.table)
DF <- data.frame(x=rnorm(9), y=rep(c("a", "b", "c"), each=3), z=rnorm(9))
head(DF, 3)

DT = data.table(x=rnorm(9), y=rep(c("a", "b", "c"), each=3), z=rnorm(9))
head(DT, 3)
tables()

DT[2, ]
DT[DT$y=="a", ]
DT[c(2,3)]

DT[, c(2,3)]
DT[, list(mean(x), sum(z))] # 계산할 때 list 활용

DT[, table(y)]

# mutate :=
DT[, w:=z^2]
DT

DT2 <- DT
DT[, y:=2]
head(DT, 3)


DT[, m:={tmp <- (x+z); log2(tmp+5)}]
DT[, a:=x>0]
DT[, b:=mean(x+w), by=a] 
DT[, b:=NULL] # 칼럼 지우기 

# .N : 마지막 행 반환
set.seed(123);
DT <- data.table(x=sample(letters[1:3], 1E5, TRUE))
DT[, .N, by=x]
DT

# keys
DT <- data.table(x=rep(c("a", "b", "c"), each=100), y=rnorm(300))
DT
setkey(DT, x)
DT['a']

DT1 <- data.table(x=c('a', 'a', 'b', 'dt1'), y=1:4)
DT2 <- data.table(x=c('a', 'b', 'dt2'), z=5:7)
setkey(DT1, x); setkey(DT2, x)
merge(DT1, DT2)


# fast reading 

big_df <- data.frame(x=rnorm(1E6), y=rnorm(1E6))
file <- tempfile()
write.table(big_df, file=file, row.names = F, col.names = T, sep="\t", quote = F) 
system.time(fread(file)) # 0.05초
system.time((read.table(file, header = T, sep="\t"))) # 4초. 약 80배 빠름 


# quiz

# 100만 달러 이상 
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/survey.csv", method = "curl") 
list.files("./data")
dateDownloaded <- date()

survey <- read.csv("./data/survey.csv")
head(survey)

library(tidyverse)
survey %>% 
        as_tibble() %>% 
        group_by(VAL) %>% 
        select(VAL) %>%
        filter(VAL==24) %>% 
        count()
        
survey %>% 
        as_tibble() %>% 
        select(FES)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "./data/NGAP.xlsx", method = "curl")        
NGAP <- readxl::read_xlsx("./data/NGAP.xlsx")
dat <- as.data.frame(NGAP[c(18:22), c(6:15)])
names(dat) <- c("City", "Zip", "CuCurrent", "PaCurrent", "PoCurrent", "Contact", "Ext", "Fax", "email Status")

dat$Zip = as.numeric(dat$Zip)
dat$Ext = as.numeric(dat$Ext)

sum(dat$Zip*dat$Ext, na.rm = T)


# xml 
library(XML)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
xml <-"./data/restaurant.xml"
download.file(fileUrl, xml, quiet = TRUE)
dat_xml<-xmlInternalTreeParse(xml)
topNode<-xmlRoot(dat_xml) # obtain access to the top node
topNode


topNode[[1]]
topNode[[1]][[1]]

xmlSApply(topNode, xmlValue)


xpathSApply(topNode, "//name", xmlValue)
zipcode <- xpathSApply(topNode, "//zipcode", xmlValue)
zipcode=zipcode %>% enframe(name = NULL) 
zipcode$value=as.numeric(zipcode$value)
nrow(zipcode[zipcode$value==21231,])


fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/microdata.csv", method = "curl")
DT <- fread("./data/microdata.csv")
DT[,list(mean(pwgtp15))]



###########################################################################################
# day3

# mySQL 

library(RMySQL)

# 데이터 베이스 접속 

ucscDb <- dbConnect(MySQL(), user="genome", host="genome-mysql.cse.ucsc.edu")

result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb);
result

hg19 <- dbConnect(MySQL(), user="genome", db="hg19", 
                  host="genome-mysql.cse.ucsc.edu")


# hg19 데이터 베이스 안에 테이블 목록 확인
allTables <- dbListTables(hg19) 

# 테이블이 갯수 확인
length(allTables)   

allTables[1:5] 


# hg 19 데이터 베이스 안에 특정 테이블의 col_name 
dbListFields(hg19, "affyU133Plus2")

# 쿼리 호출
dbGetQuery(hg19, "select count(*) from affyU133Plus2") # nrow

# 수정이나 삭제의 경우 dbSendQuery 사용 
# ex) dbSendQuery(conn, "delete from score)


# hg19 DB에서 특정 테이블 블러오기
affyData <- dbReadTable(hg19, "affyU133Plus2")  
head(affyData)

# select a specific subset 
# DB안에 각 테이블의 용량이 커서 R로 불러오기 곤란할 수 있음 
# 특정 테이블의 특정 부분만 추출하는 것이 필요 

query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query)
quantile(affyMis$misMatches)

affyMisSmall <- fetch(query, n=10)
dbClearResult(query)
dim(affyMisSmall)

# DB 연결 종료 
dbDisconnect(hg19) 

# 서버에 엑세스하거나 데이터를 삭제 하지 말 것. 우선 SELECT 만 사용 


# 내 데이터 베이스안에 데이터가 있는 경우 
# mydb <- dbConnect(MySQL(), user="root", password="", dbname="DB에 저장된 데이터명")

# 연결된 mydb에 show tables 쿼리을 보내서 자료를 가져오겠다는 의미. 문법은 sql과 동일     
# result <- dbGetQuery(mydb, "show tables;"); dbDisconnect(ucscDb);

hg19 <- dbConnect(MySQL(), user="genome", db="hg19", 
                  host="genome-mysql.cse.ucsc.edu")


# hg19 데이터 베이스 안에 테이블 목록 확인
allTables <- dbListTables(hg19) 


##################################################################################################
# day4 

# HDF5

source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")

library(rhdf5)
created <- h5createFile("example.h5")
created

# file 안에 그룹 만들기 
created <- h5createGroup("example.h5", "foo")
created <- h5createGroup("example.h5", "baa")
created <- h5createGroup("example.h5", "foo/foobaa") # subgroup 
h5ls("example.h5")

A <- matrix(1:10, nrow=5, ncol=2)
h5write(A, "example.h5", "foo/A")
B <- array(seq(0.1, 2.0, by=0.1), dim=c(5, 2, 2))
attr(B, "scale") <- "liter" # 속성 지정 
h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")

df <- data.frame(1L:5L, seq(0, 1, length.out = 5),
                 c("ab", "cde", "fghi", "a", "s"), stringsAsFactors = F)
df

h5write(df, "example.h5", "df")
h5ls("example.h5")


# reading data

readA=h5read("example.h5", "foo/A")
readB=h5read("example.h5", "foo/foobaa/B")
readdf=h5read("example.h5", "df")
readA


# writing and reading chunks

# 1:3행 1열에 12, 13, 14로 값 바꾸기 
h5write(c(12, 13, 14), "example.h5", "foo/A", index=list(1:3, 1))
h5read("example.h5", "foo/A")

h5read("example.h5", "foo/A", index = list(1:3, 1)) # index로 subset 가능 


# reading data from the Web

con <- url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlcode <- readLines(con)
close(con)
htmlcode

library(XML)
url <-  "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes = T)
xpathSApply(html, "//title", xmlValue)

library(httr)
html2=GET(url) # 웹 페이지 불러오기 
content2=content(html2, as="text") # text로 추출
content2

parsedHtml=htmlParse(content2, asText = T) # html 형태로 변
# parsing : 어떤 데이터를 다른 모양으로 가공하는 걸 의미
parsedHtml
xpathSApply(parsedHtml, "//title", xmlValue) # 원하는 항목의 자료(xmlValue)를 가져오기 


# Accessing websites with passwords
pg1=GET("http://httpbin.org/basic-auth/user/passwd")
pg1

pg2=GET("http://httpbin.org/basic-auth/user/passwd", 
        authenticate("user", "passwd")) # id, password가 있을 경우 입력 
pg2

names(pg2)


# 반복인증 없이 인증을 저장할 때 
google=handle("http://google.com")
pg1=GET(handle = google, path="/")
pg2=GET(handle=google, path="search")



###############################################################################################
# day5

# http 웹 페이지 불러올 때 
library(httr) 

myapp <- oauth_app("twitter", key = "yourConsumerKeyHere", secret = "yourConsumerSecretHere")
sig <- sign_oauth1.0(myapp, 
                     token = "YourTokenHere", 
                     token_secret = "YourTokenSecretHere")

# GET : 웹페이지 불러오기 
homeTL <- GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig) 


# 불러온 웹페이지 데이터를 json 양식으로 전환 
json1=content(homeTL) # 서버에서 준 데이터 확인 
json2=jsonlite::fromJSON(toJSON(json1))

# 원하는 데이터 추출 
json2[1, 1:4]


# quiz

library(sqldf)
library(data.table)
library(tidyverse)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"

path <- file.path("./getting and cleaning data/data", "sso6.csv")
download.file(url, path)

acs <- data.table(read.csv(path))
acs

q <- sqldf("select pwgtp1 from acs where AGEP<50")
q


uniq1=data.frame(unique(acs$AGEP))
uniq2=sqldf("select distinct AGEP from acs")

uniq1=arrange(uniq1)
uniq2=arrange(uniq2)

all.equal(uniq1, uniq2) # 어느 부분이 다른지 반환. identical()은 T, F만  



con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlcode <- readLines(con)
close(con)
c(nchar(htmlcode[10]), nchar(htmlcode[20]), nchar(htmlcode[30]), nchar(htmlcode[100]))

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
dat <- readLines(url, n=10)
dat


# read.fwt() : 일정한 간격, 고정된 폭 구조의 외부 데이터 불러오기
# sas 데이터 입력방식이랑 비슷함 

dat <- read.fwf(url, skip=4, widths = c(12, 7, 4, 9, 4, 9, 4, 9, 4))
head(dat)
sum(dat[, 4])


