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

