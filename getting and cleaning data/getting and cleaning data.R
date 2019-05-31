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





