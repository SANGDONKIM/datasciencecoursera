
# day1

# scala
# 구성인자가 1인 벡터 


# vector
# 구성인자가 1개 이상인 벡터
# 동일한 유형의 1차원 데이터 구조 
# 1개의 경우 scala


# factor
# 범주형(명목형 또는 순서형) 데이터 구조 

x=factor(c("yes", "yes", "no", "yes", "no"))
table(x)
unclass(x)


x=factor(c("yes", "yes", "no", "yes", "no"), 
         levels = c("yes", "no"))
# factor 요소의 순서를 levels로 지정. 지정 안할 경우 알파벳 순서로 정렬  

unclass(x) # 1 : yes, 2: no로 바뀜 
# level 표현 없이 class의 특징을 없애고 상수만 출력. 속성에 따라 상수에 매칭되는 데이터 값을 같이 출력 

x <- c("Middle", "Low", "High")
x <- factor(x, order=T, levels=c("Low", "Middle", "High"))
x
# 수준(level)에 순서를 부여할 경우 order=T, levels = 지정 


# matrix
# 동일한 유형의 2차원 데이터 구조 

m1 <- matrix(1:12, nrow = 4)
m1
m2 <- matrix(1:12, nrow=4, byrow=T) # byrow=T : 행기준으로 데이터를 채워나
m2


# array
# 동일한 유형의 데이터가 2차원 이상으로 구성된 구조
# 쉽게 말하면 행렬(2차원)을 층층히 쌓아올린 아파트같은 느낌

a1 <- array(1:24, c(2,3,4)) # 2*3행렬 4층 짜리 데이터 구조 생성
a1


# dataframe
# 데이터 유형에 상관없이 2차원 형태의 데이터 구조

# 메트릭스와 차이점: 다른 class의 objects가 올 수 있음. 
# 메트릭스는 같은 class만 가능 
# data.matrix() : 데이터 프레임을 매트릭스로 변환할 때 사용 

d1 <- c(1,2,3,4)
d2 <- c("kim", "lee", "choi", "park")

d3 <- data.frame(cust_id=d1, last_name=d2) # 변수명 부여
d3


x=data.frame(foo=1:4, bar=c(T, T, F, F))
x

nrow(x)
ncol(x)

x=1:3  
names(x)

names(x)=c("foo", "bar", "norf")
x
names(x)


# list
# 벡터, 행렬, 배열, 데이터프레임 등과 같은 서로 다른 구조의 데이터를 모두 묶은 객체를 말함

L1 <- c(1,2,3,4)
L2 <- matrix(1:6, 3, byrow = T)
L3 <- array(1:24, c(3,4,2))
L4 <- data.frame(cust_id=c(1,2,3,4), last_name=c("kim", "lee", "choi", "park"))
L5 <- list(L1, L2, L3, L4)
L5


x=list(a=1, b=2, c=3)
x

m=matrix(1:4, nrow=2, ncol=2)


dimnames(m)=list(c("a", "b"), c("c", "d")) 
# matrix에 이름을 부여할 때는 dimnames 함수 사용
# list의 첫번째가 행, 두번째가 열 순서로 이름 부여 

m

# 결측값
# NA: 결측값, class로 분류되며 character NA, integer NA, NAN을 포괄함
# NaN: Not a number 의 약자로서 0/0처럼 수학적으로 정의되지 않은 것을 의미  
# NULL: 값이 없다는 의미 

x=c(1, 2, NA, 10 ,3)
is.na(x) # NA인 경우 T, 아닌 경우 F

is.nan(x)

x=c(1, 2, NaN, NA, 4)

is.na(x)
is.nan(x)



# reading data
# read.table, read.csv 
# readLins() : 한줄씩 있는 텍스트 파일 불러올 때 
# source() : R code 파일의 데이터를 읽어올 때 (dump)
# dget() : R code 파일의 데이터를 읽어올 때 (dput)
# load() : 저장된 workspace에서 데이터를 불러올 때 
# unserialize() : binary 형태의 단일 R object를 읽어올 때 

# write 함수 
# write.table, write.csv, write.Lines, dump, dput, save, serialize


# read.table 함수 
# file : 파일 이름
# header : 데이터 라벨 유무 
# sep : 구분자 (",", "\t", "" 등)
# colClasses : character vector로 각 column이 어떤 class 형태인지 설명(ex. numeric, logical 등)
# nrows: dataset 행의 수 
# comment.char : 데이터 파일에서 주석을 사용할 경우 주석의 시작 문자열 (default "#" : #으로 시작하는 라인은 무시)
# skip : 처음 시작 시에 무시할 라인의 수 
# stringAsFactor : character 변수를 Factor 형태로 저장해야되는지 여부 (default: T)

# read.csv 함수 
# read.table과 동일 
# 기 구분자가 "," 임 



# 대용량 데이터 reading 

# 파일에 주석이 없을 경우, comment.char=""로 설정하면 조금 빨라짐

# colClass 설정
# 기본값 대신 각 column에 class type을 지정해줄 경우 보다 빠르게 데이터를 불어올 수 있음

# 각 column의 class를 알아내는 방법

initial=read.table("datatable.txt", nrows=100)
classes=sapply(initial, class)
tabAll=read.table("datatable.txt", colClasses = classes)

# 보통 class를 지정해주면 2배 정도 빨라짐 


# 메모리 계산 방법

# 1,500,000 행 120 열 데이터 셋의 경우
# 1500000*120*8byte/numeric
# =1440000000 bytes
# =1400000000 /2^20 byte MB
# =1,373.29 MB
# =1.34 GB



# 데이터 writing 
# 1) textual format 저장 
# - csv 파일과 다르게 R에서 데이터 처리를 하기에 유용한 tabular data 형태의 format을 말함

# dumping/dputing : csv, table과 다르게 metadata를 저장하고 있어 다시 각 데이터 타입에 대해 명시할 필요 없음
# supervison, git으로 관리 가능
# 단, 메모리를 효율적으로 쓰는 형태는 아님

y=data.frame(a=1, b="a") # origin dataframe 생성
dput(y)  
dput(y, file = "y.R") # 지정된 경로에 y.R 파일로 저장
new.y=dget("y.R") # dput으로 저장된 파일 불어오기
new.y # 이전과 동일한 출력값 생성

x="foo"
y=data.frame(a=1, b="a")
dump(c("x", "y"), file="data.R") # 여러 object를 저장가능. dput은 한 개만 가능 
rm(x, y) # 데이터 x, y 지우기 

source("data.R") # 여러 object 불러오기 가능. dget은 한개만 가능. 이전 데이터 그대로 불러올 수 있 
x;y

hw1=read.csv("hw1_data.csv")
names(hw1)
colnames(hw1)

hw1[1:2, ]
nrow(hw1)
hw1[152:153, ]
hw1[47,1]

sum(is.na(hw1$Ozone))

mean(hw1[,1], na.rm = T)
k=hw1["Ozone">=31 & "Temp">=90, ]
colnames(k)
mean(k[,2], na.rm = T)

k=hw1["Month">=6, ][32:61,]
mean(k[,4], na.rm = T)
k=hw1[hw1$Month==5,]
k
max(k[,1], na.rm = T)
x=4L
class(x)
x<-4L
x=c(4,"a", T)
x=list(2, "a", "b", T)
x[[2]]
x=c(17, 14, 4, 5, 13, 12, 10)
x[x>10]==4
x
x[x%in%1:5]=0
x=1:4; y=2:3
class(x+y)


###########################################################################################
# day2

if (x>3) {
        y=10
} else {
        y=0
}
y

y=if (x>3) {
        10
} else {
        0
}
y

for (i in 1:10) {
        print(i)
}

x=c("a", "b", "c", "d")

for (i in 1:4) {
        print(x[i])
}
for (i in seq_along(x)) {
        print(x[i])
}

for (letter in x) {
        print(letter)
}

for (i in 1:4) print(x[i])

seq()
seq(1, 10)
seq(from=3, to=10)
seq(to=3, from=10)
seq(from=1, to=10, length.out = 6) # length.out : 원하는 벡터의 길이
seq(from=1, to=10, along.with = 10) # along.with: 인수 값으로 전달되는 벡터의 길이만큼 seq 실행
seq(from=1, to=10, along.with = 1) # 1, 10 둘다 벡터의 길이가 1이므로 1 반환
seq(from=1, to=10, along.with = 1:3) 
seq(from=1, to=10, along.with = 1:5)
# seq_along() : 무조건 1부터 시작하며, 인수로 seq의 along.with 값만 받는 함수라고 생각하면 됨.
# 주어진 벡터의 길이를 따라가겠다는 의미
seq_along(1:5)
seq_along(4:10)
seq_along(x)

x=matrix(1:6, 2, 3)
x
for (i in seq_len(nrow(x))) {
        for (j in seq_len(ncol(x))) {
                print(x[i,j])
        }
}

# seq_len() : 입력받은 인자만큼의 seq를 수행하겠다는 의미 
seq_len(10)


count=0
while(count<10) {
        print(count)
        count=count+1
}

z=5
while(z>=3 && z<=10) {  # &&(and): 벡터의 첫번째 결과만 
        print(z)
        coin=rbinom(1, 1, 0.5) # rbinom(n=관측치 갯수, size=시행횟수, prob=확률)
        
        if (coin==1) {
                z=z+1
        } else {
                z=z-1
        }
}

# repeat : 무한 루프 생성. 루프를 나가기 위해서는 break 사용 

x0=1
tol=1e-8

repeat {
        x1=computeEstimate()
        
        if (abs(x1-x0)<tol) {
                break
        } else {
                x0=x1
        }
}

# next : 루프의 반복을 skip하는데 사용 

for (i in 1:100) {
        if (i<=20) {
                ## skip the first 20 iteration
                next
        }
        ## Do something here
}


# function

add2=function(x, y) {
        x+y
}
add2(3,5)


above10=function(x) {
        use=x>10 # logical vector 
        x[use]
}

above=function(x, n) {
        use=x>n
        x[use]
}

x=1:20
above(x, 12)

above=function(x, n=10) { # n=10으로 default 설정
        use=x>n
        x[use]
}
above(x)


columnmean=function(y) {
        nc=ncol(y)
        means=numeric(nc)
        for (i in 1:nc) {
                means[i]=mean(y[, i])
        }
        means
}
columnmean(airquality)

columnmean=function(y, removeNA=T) {
        nc=ncol(y)
        means=numeric(nc)
        for (i in 1:nc) {
                means[i]=mean(y[, i], na.rm = removeNA)
        }
        means
}  
columnmean(airquality)



columnmean=function(y) {
        nc=ncol(y)
        means=numeric(nc)
        for (i in 1:nc) {
                means[i]=mean(y[, i], na.rm = T)
        }
        means
}  
columnmean(airquality)



library(swirl)
install_from_swirl("R Programming")
swirl()
don


##############################################################################################
# day3
# identical # 두 객체가 같은지 비교하는 함수 
# ||: or에서 벡터의 첫 번째 결과만 비교
# &&: and에서 벡터의 첫번째 결과만 비교
# xor : 둘 중 하나만 거짓일 경우 TRUE
# is.TRUE() : 벡터의 길이가 1이면서 TRUE일 경우 TRUE
tt <- c(TRUE, TRUE)
isTRUE(tt) 


mydata <- rnorm(100)
sd(x=mydata)
sd(x=mydata, na.rm = F)
sd(na.rm = F, x=mydata)
sd(na.rm = F, mydata)

args(lm)

lm(data=mydata, y~x, model=FALSE, 1:100)
lm(y~x, mydata, 1:100, model=FALSE)


myplot <- function(x, y, type="l", ...) { # plot function 에는 x, y, type을 제외하고 많은 argument가 있음
        plot(x, y, type=type, ...) # ...는 지정하지 않은 argument를 그대로 쓸 수 있게 해줌 
} # argument의 수를 미리 알 수 없을 때에도 효과적임 


args(paste)
args(cat)

args(paste)
paste("a", "b", sep=":")
paste("a", "b", se=":") 
# ...의 경우 partial matching 불가능. 정확한 argument를 입력해주어야함. 
# 함수에 따라 partial matching이 가능한 경우도 있음 
paste("a", "b", ":")


f <- function(x, y) {
        x^2+y/z
}
f(2,4, 1)

# lexical scope : 변수가 정의된 블록 내부에서만 변수를 접근할 수 있는 규칙을 말함
# 전역변수 : 콘솔에서 그냥 변수를 선언할 경우 ex) x<- 1
# 지역변수 : 함수 내에서 변수를 선언할 경우 
# 전역변수와 지역변수의 이름이 겹치면 지역변수를 우선시함 
# 함수내부에서 x <- 10 를 입력하면 지역변수 할당, x <<- 10을 입력하면 전역변수 할당


make.power <- function(n) {
        pow <- function(x) {
                x^n
        }
        pow
}
cube <- make.power(3)
cube
square <- make.power(2)
cube(3)
square(3)

ls(environment(cube))
get("n", environment(cube))

ls(environment(square))
get("n", environment(square))


y <- 10

f <- function(x) {
        y <- 2
        y^2+g(x)
}

g <- function(x){
        x+y
}
f(3)
g(3)

rm(y)
g <- function(x) {
        a <- 3
        x+a+y
}
g(2)

y <- 3
g(2)



make.NegLogLik <- function(data, fixed=c(FALSE, FALSE)) {
        params <- fixed
        function(p) {
                params[!fixed] <- p
                mu <- params[1]
                sigma <- params[2]
                a <- -0.5*length(data)*log(2*pi*sigma^2)
                b <- -0.5*sum((data-mu)^2)/(sigma^2)
                -(a+b)
        }
}


set.seed(1)
normals <- rnorm(100, 1, 2)
nLL <- make.NegLogLik(normals)
nLL
ls(environment(nLL))


optim(c(mu=0, sigma=1), nLL)$par

# sigma=2로 고정 
nLL <- make.NegLogLik(normals, c(FALSE, 2))
optimize(nLL, c(-1, 3))$minimum

# mu=1로 고정
nLL <- make.NegLogLik(normals, c(1, FALSE))
optimize(nLL, c(1e-6, 10))$minimum


nLL <- make.NegLogLik(normals, c(1, FALSE))
x <- seq(1.7, 1.9, len=100)
y <- sapply(x, nLL)
plot(x, exp(-(y-min(y))), type="l")

nLL <- make.NegLogLik(normals, c(FALSE, 2))
x <- seq(0.5, 1.5, len=100)
y <- sapply(x, nLL)
plot(x, exp(-(y-min(y))), type="l")


swirl()

# ... 이후에 모든 인수는 default value여야 함. 즉 값이 지정되어 있어야 함 

######################################################################################################
# day4

# Dates
# 1970-01-01에서 현재 값까지를 내부적으로 저장 

# Time 
# POSIXct, POSIXlt class 기
# 1970-01-01에서 현재까지의 초 값을 내부적으로 저장 

x <- as.Date("1970-01-01")
x
unclass(x) # class의 특징을 지우고 상수값 표시 
unclass(as.Date("1970-01-02"))

# Date : 날짜만 나타낼 수 있음. 시간 x. 
# POSIXct : 날짜 및 시간 class로 일초 간격으로 시간을 나타냄. 날짜 및 시간 정보를 저장할 때 추천
# POSIXlt : 날짜 및 시간 class로 연도, 월, 일, 시, 분, 초를 포함하는 9개 원소로 된 리스트에 저장됨. 
# 월 또는 시와 같은 날짜의 부분을 추출하기 쉬움. 보통 데이터 중간 처리과정에 쓰이고 저장과정에는 안쓰임. 

# weekday : give the day of week
# months : give the month name
# quarters : give the quarter number ("Q1", "Q2", "Q3", "Q4")


x <- Sys.time()
x

p <- as.POSIXlt(x)
p

names(unclass(p))
p$sec

x <- Sys.time()
x # already POSIXct format
unclass(x) # large number

# strptime

datestring <- c("January 10, 2012 10:40", "December 9, 2011 9:10")

x <- strptime(datestring, "%B %d, %Y %H:%M")
x

x <- as.Date("2012-01-01")
y <- strptime("9 Jan 2011 11:34:21", "%d %B %Y %H:%M:%S")
x <- as.POSIXlt(x)
x-y # 계산하려면 같은 class여야함

x <- as.Date("2012-03-01")
y <- as.Date("2012-02-28")
x-y

x <- as.POSIXct("2012-10-25 01:00:00")
y <- as.POSIXct("2012-10-25 06:00:00", tz="GMT")

y-x


library(swirl)
swirl()

# Quiz
cube <- function(x, n) {
        x^3
}
cube(3)

x <- 1:10
if (x>5) {
        x <- 0
}

f <- function(x) {
        g <- function(y) {
                y + z
        }
        z <- 4
        x + g(x)
}
z <- 10
f(3)

x <- 5
y <- if(x < 3) {
        NA
} else {
        10
}
y

h <- function(x, y = NULL, d = 3L) {
        z <- cbind(x, d)
        if(!is.null(y))
                z <- z + y
        else
                z <- z + f
        g <- x + y / z
        if(d == 3L)
                return(g)
        g <- g + 10
        g
}
h(3, 1)

#####################################################################################################
# assignment 1
setwd("C:/Users/sangdon/Desktop/코세라/rprog_data_specdata")

pollutantmean <- function(directory, pollutant, id=1:332) {
        
        directory <- paste0(getwd(),"/", directory, "/")
        file_list <- list.files(directory)
        data <- numeric() # 빈 공간 할당 
        for (i in id) {
                
                file_dir <- paste0(directory, file_list[i])
                file_data <- read.csv(file_dir)
                
                data <- rbind(data, file_data)
        }
        mean(data[[pollutant]], na.rm = T)
}

pollutantmean("specdata", "sulfate", id=1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "sulfate", 34)
pollutantmean("specdata", "nitrate")

############################################################################################
setwd("C:/Users/sangdon/Desktop/코세라/rprog_data_specdata")

# 함수를 만들 때는 첫 케이스를 완벽하게 만들고 loop 진행 필요 

list.files("specdata")

file.list <- list.files("specdata", pattern = ".csv", full.names = T)
file.list[1]
read.csv(file.list[1])        
sum(complete.cases(read.csv(file.list[1])))

nobs <- numeric()
nobs <- c(nobs, 117)
nobs


nobs <- numeric()
nobs <- c(nobs, sum(complete.cases(read.csv(file.list[1]))))
nobs
nobs <- c(nobs, sum(complete.cases(read.csv(file.list[2]))))
nobs
nobs <- c(nobs, sum(complete.cases(read.csv(file.list[3]))))
nobs


complete <- function(directory, id=1:332) {
        
        file.list <- list.files(directory, pattern = ".csv", full.names = T)
        nobs <- numeric() # 처음 시작할 때 저장할 곳 지정 
        for (i in id) {
                data <- read.csv(file.list[i])
                sumdata <- sum(complete.cases(data))
                nobs <- c(nobs, sumdata)
        }
        data.frame(id, nobs)
}
cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)

cc <- complete("specdata", 54)
print(cc$nobs)

set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])


#################################################################################################

# 완전히 관찰된 케이스의 개수가 임계값(threshold)보다 커야함.
# 임계값보다 클 경우 sulfate와 nitrate와의 correlation 반환 
# 임계값 이하일 경우 vector 0 반환 


file.list <- list.files("specdata", full.names = T, pattern = ".csv")

data <- read.csv(file.list[1])
numvect <- vector(mode = "numeric", length = 0)
cases <- data[complete.cases(data[, c("sulfate", "nitrate")]), ]
head(cases)
head(cases["sulfate"])

if (nrow(cases)>100) {
        filter_sul <- cases["sulfate"]
        filter_nit <- cases["nitrate"]
        numvect <- c(numvect, cor(filter_sul, filter_nit))
} 
numvect

corr <- function(directory, threshold = 0) {
        file.list <- list.files(directory, full.names = T, pattern = ".csv")
        numvect <- c()
        
        for (i in 1:length(file.list)) {
                data <- read.csv(file.list[i])
                cases <- data[complete.cases(data[, c("sulfate", "nitrate")]), ]
                
                if (nrow(cases) > threshold) {
                        filter_sul <- cases["sulfate"]
                        filter_nit <- cases["nitrate"]
                        numvect <- c(numvect, cor(filter_sul, filter_nit))
                }
        }
        numvect
}

cr <- corr("specdata")
cr <- sort(cr)
set.seed(868)
out <- round(cr[sample(length(cr), 5)], 4)
print(out)

cr <- corr("specdata", 129)                
cr <- sort(cr)                
n <- length(cr)                
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)

cr <- corr("specdata", 2000)                
n <- length(cr)                
cr <- corr("specdata", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))



#####################################################################################################
# day5

# lapply : 특정 함수를 리스트의 각 요소별로 적용해서 list로 반환
# lapply(x, FUN, ...)
# x : 반환되는 list(list가 아닐 경우 강제로 list로 변환. 안될 경우 error), FUN : 함수 이름 
# C 코드 기반이어서 속도가 더 빠름 


x <- list(a=1:5, b=rnorm(10))
lapply(x, mean)# lapply는 항상 list를 반환함

x <- list(a=1:4, b=rnorm(10), c=rnorm(20, 1), d=rnorm(100, 5))
lapply(x, mean)

x <- 1:4
lapply(x, runif) # runif : 균등분포에서 난수발생 함수


x <- 1:4
lapply(x, runif, min=0, max=10) # U(0,10)

x <- list(a=matrix(1:4, 2, 2), b=matrix(1:6, 3, 2))
x

lapply(x, function(elt) elt[ ,1]) # x를 함수에 인수로 넣으라는 의미 
# 익명의 원하는 함수를 만들어서 적용할 수 있음 

# sapply
# 데이터 프레임의 여러변수에 함수 명령어 동시에 적용. 벡터 or 행렬 반환  
# 길이가 1인 요소의 list라면 결과로 list가 아닌 벡터를 반환
# 길이가 1 이상의 동일한 벡터를 가지는 list라면 list가 아닌 matrix 반환 
# 일반적인 경우 list 반환 (lapply와 동일)


x <- list(a=1:4, b=rnorm(10), c=rnorm(20, 1), d=rnorm(100, 5))
lapply(x, mean)
sapply(x, mean) # 요소의 길이가 전부 1이므로 벡터 반환. simplify=F : 무조건 list 반환  

mean(x) # list에 적용할 수 없음 


# apply
# apply(x, MARGIN, FUN)
# x: 함수를 적용할 array or matrix
# MARGIN : 1이면 행방향, 2면 열방향, c(1,2)는 행과 열방향 둘

# matrix의 행이나 열의 특정 연산을 수행할 때 사용
# 일반적으로 array 형태에서 사용함
# for, while 구분보다 빠르지 않음. 코드를 간결히 할 때 유용 


x <- matrix(rnorm(200), 20, 10)
apply(x, 2, mean)
apply(x, 1, sum)

# rowSums=apply(x, 1, sum)
# rowMeans=apply(x, 1, mean)
# colSums=apply(x, 2, sum)
# colMeans=apply(x, 2, mean)

x <- matrix(rnorm(200), 20, 10)
apply(x, 1, quantile, probs=c(0.25, 0.75))


a <- array(rnorm(2*2*10), c(2, 2, 10))
apply(a, c(1,2), mean)
rowMeans(a, dims = 2)

a <- array(1:24, c(2,3,4))
a
apply(a, c(1, 2), sum)
rowMeans(a, dims = 2)
apply(a, c(2, 1), sum)


library(swirl)
swirl()


###############################################################################################
# day6

# mapply 
# 하나의 인수가 아닌 여러개의 인수를 함수에 적용할 때 사용 

str(mapply)


list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))
mapply(rep, 1:4, 4:1)

noise <- function(n, mean, sd) {
        rnorm(n, mean, sd)
}
noise(5, 1, 2)

noise(1:5, 1:5, 2)

mapply(noise, 1:5, 1:5, 2)

list(noise(1, 1, 2), noise(2, 2, 2), noise(3, 3, 2), noise(4, 4, 2), noise(5, 5, 2))




# tapply

# 요인의 수준별로 특정 벡터에 함수 명령어를 동시에 사용  
# 요인 변수를 기준으로 그룹별로 나눠서 통계분석을 하고자 할 때 유용 
x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10)
f
tapply(x, f, mean)
tapply(x, f, mean, simplify = F) # simplify=F : list로 출력
tapply(x, f, range)


# split
# factor에 의해서 object를 나눠주는 기능 수행
# drop=T : empty factor level은 무시하고 적용할지 유무 결
# list 반환 
str(split)

x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10)
split(x, f)

lapply(split(x, f), mean)



library(datasets)
head(airquality)

s <- split(airquality, airquality$Month)
s

lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = T))

x <- rnorm(10)
f1 <- gl(2, 5)
f2 <- gl(5, 2)
f1
f2

interaction(f1, f2)
str(split(x, list(f1, f2)))
str(split(x, list(f1, f2), drop=T))

#################################################################################################
# day7

# 오류의 종류 

# message : 일반적인 notification/diagnostic message 출력되고 코드는 계속 실행

# warning : 오류가 있으나 수행에 치명적이지 않은 상태를 출력하고 코드는 계속 실행

# error : 수행에 치명적인 문제 발생을 나타내며, 코드 수행 정지 

# condition : 개발자가 직접 어떤 조건을 만들어서 조건에 따라 출력을 다르게 만들어 코드가 재대로
# 수행하는지를 파악할 수 있는 기능 



log(-1)


printmessage <- function(x) {
        if(x>0)
                print("x is greater than zero")
        else
                print("x is less than or equal to zero")
        invisible(x) # 함수의 최종결과가 console 화면에 출력되지 않음  
}

printmessage(1)
printmessage(NA)

printmessage2 <- function(x) {
        if(is.na(x))
                print("x is missing value")
        else if(x>0)
                print("x is greater than zero")
        else
                print("x is less than or equal to zero")
        invisible(x) # 함수의 최종결과가 console 화면에 출력되지 않음  
}

printmessage2(NA)

x <- log(-1)
printmessage2(x)



# debugging tool in r 

# trackback : error 발생 시에 어떤 함수들이 호출되었는지 출력. error가 없을 경우 아무런 기능 x 

# debug : debug 모드로 코드 한줄씩 실행을 하면 수행결과를 볼 수 있음. 

# browse : 함수 내 원하는 부분부터 디버그할 때 사용. 

# trace : 함수에 디버깅 코드를 넣어 거의 실시간으로 디버깅 
# recover : 활성화되어있는 함수에서 선택적으로 디버깅 
# 에러가 발생했을 때 바로 잡기 위해 추천을 해주는 옵션 options(error=recover)

mean(x)
traceback() 

lm(y~x)
traceback()

debug(lm)
lm(y~x)
n

options(error=recover)
options(error = stop)
read.csv("nosuchfile")

?iris
head(iris)
iris$Sepal.Length
tapply(iris$Sepal.Length, iris$Species, mean)

colMeans(iris)

apply(iris[,1:4], 2, mean)

head(mtcars)

tapply(mtcars$cyl, mtcars$mpg, mean)
lapply(mtcars, mean)
sapply(split(mtcars$mpg, mtcars$cyl), mean)
sapply(mtcars, cyl, mean)
?mtcars

a=tapply(mtcars$hp, mtcars$cyl, mean)
a[1]-a[3]
round(a[1]-a[3])


##############################################################################################
# day8

# assignment 2 



f <- function(x, y) {
        x^2+y/z # z는 자유변수
}

# scoping rule은 어떻게 자유변수의 값을 할당하는지를 결정한다. 자유변수는 지정된 인수가 아니며
# 지역변수(함수의 body안에 할당된)가 아니다. 
# 자유변수의 값은 정의된 함수의 환경에서 찾게 되며, global environment까지 범위를 넓혀가며 찾게됨.
# 패키지, global environment 까지 없으면 error 출력됨 

make.power <- function(n) {
        pow <- function(x) {
                x^n
        }
        pow
}
cube <- make.power(3)
square <- make.power(2)
cube(3)
square(3)
cube
ls(environment(cube))

# lexical vs dynamic scoping

y <- 10

f <- function(x) {
        y <- 2
        y^2 + g(x)
}

g <- function(x) {
        x*y
}

f(3)


g <- function(x) { # x : formal argument
        a <- 3
        x+a+y
        ## y is free variable
}
g(2) # global environment에 저장
y <- 3 # global environment에 저장 
g(2) 

x <- 1
h <- function(n) {
        y <- 2
        i <- function() {
                z <- 3
                c(x,y,z)
        }
        i()
}

h()

j <- function(x) {
        y <- 2
        function() {
                x+2*y
        }
}

k <- j(1)
k()



# example

# global environment - > makeVectors environment - > (set() environment, get() environment, 
# setmean() environment, 
# getmean() environment, 
# x, m)

makeVector <- function(x = numeric()) {
        m <- NULL 
        set <- function(y) {
                x <<- y # parent environment에 변수 할당
                m <<- NULL # parent environment에 변수 할당
        }
        get <- function() x # 함수 안에 값이 정의되지 않았기 때문에 parent environment에서 값을 찾음 
        setmean <- function(mean) m <<- mean # m을 parent environment에 세팅 
        getmean <- function() m # 함수 안에 값이 정의되지 않았기 때문에 parent environment에서 값을 찾음
        list(set = set, get = get, 
             setmean = setmean,
             getmean = getmean)
}

makeVector() 
# makevector - > function : set, get, setmean, getmean # object : x, m  

myvector <- makeVector(1:15) 
# myvector - > set, get, setmean, getmean # object : x=1:15, m 

myvector$set()
myvector$get() # set이 설정되지 않아도 작동 


# cachemean은 makevector 타입의 입력 인자를 요구함. 
# 일반 벡터를 넣을 경우 $getmean이 존재하지 않음. $는 atomic vector에서 작동하지 않음 
# atomic vector : 문자(character), 숫자(numeric, 실수), 정수(integer, 2L 등 L로 표시), 
#                 논리값(logical), 복소수(complex)


cachemean <- function(x, ...) {
        m <- x$getmean()  
        if(!is.null(m)) {
                message("getting cached data")
                return(m)
        }
        data <- x$get()
        m <- mean(data, ...)
        x$setmean(m)
        m
}


aVector <- makeVector(1:10) 
aVector$get() # x 값을 얻음
aVector$getmean() # m 값을 가져오며, 이 값은 NULL이어야함
aVector$set(30:50) # 새 벡터값으로 재설정
cachemean(aVector) # 계산된 평균은 1:10이 아니라 30:50임
aVector$getmean() # 값을 저장(cached)했기 때문에 값을 직접 얻어라



makeInversematrix <- function(x = matrix()) {
        invs <- NULL # 비어있는 값 할당
        set <- function(y) {
                x <<- y # parent environment에 변수 할당
                invs <<- NULL # parent environment에 변수 할당
        }
        get <- function() x # get()하면 x값 출력
        setInvs <- function(solvemat) invs <<- solvemat
        getInvs <- function() invs
        list(set = set, get = get,
             setInverse = setInvs,
             getInverse = getInvs)
}

funs <- makeInversematrix()
funs$set(matrix(c(1,2,3,4), 2))
funs$setInverse()
funs$get()
funs$getInverse()


cacheSolve <- function(x, ...) {
        invs <- x$getInverse()  
        if(!is.null(invs)) { # is.null() : ifelse null value exist, TRUE, FALSE) 
                message("getting cached data")
                return(invs)
        }
        data <- x$get()
        invs <- solve(data)
        x$setInverse(invs)
        invs
}
cacheSolve(funs)



##############################################################################################


makeCacheMatrix <- function(x = matrix()) {
        inv <- NULL
        set <- function(y) {
                x <<- y  
                inv <<- NULL 
        }
        get <- function() x 
        list(set = set, get = get)
}
funs <- makeCacheMatrix()
funs$set(matrix(1:4, 2))
funs$get()




makeCacheMatrix <- function(x = matrix()) {
        inv <- NULL
        set <- function(y) {
                x <<- y  # set 함수 밖에 생성 
                inv <<- NULL # set 함수 밖에 생성 
        }
        
        get <- function() x # set함수 밖에 할당된 x값을 얻는 함수
        
        setInverse <- function() inv <<- solve(x) # global environment에 inv 값 생성
        getInverse <- function() inv # getInverse에 inv값 할당. getInverse()로 출력
        
        list(set = set, get = get)
}
fun <- makeCacheMatrix()
fun$set()
fun$set(matrix(1:4, 2))
fun$get()
fun$setInverse()
funs$getInverse()

x <- funs
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        inv <- x$getInverse()
        if (!is.null(inv)) { # 반환 값에 NULL이 저장되어 있으면 TRUE, 그렇지 않으면 FALSE
                message("getting cached data")
                return(inv)
        }
        mat <- x$get()
        inv <- solve(mat, ...)
        x$setInverse(inv)
        inv
}
cacheSolve(funs)

funs <- makeCacheMatrix()
funs

funs$set()
funs$set(matrix(1:4, 2))
funs$get()
funs$setInverse()
funs$getInverse()



#################################################################################################

makeCacheMatrix1 <- function(x = matrix()) {
        inv <- NULL
        set <- function(y){
                x <<- y
                inv <<- NULL
        }
        get <- function() x
        setInverse <- function(solveMatrix) inv <<- solveMatrix
        getInverse <- function() inv
        list(set = set, get = get, 
             setInverse = setInverse, getInverse = getInverse)
}
funs <- makeCacheMatrix1()
funs$set(matrix(1:4, 2))
## This function computes the inverse of the special "matrix" returned by makeCacheMatrix above.
cacheSolve1 <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        inv <- x$getInverse()
        if(!is.null(inv)){
                message("getting cached data")
                return(inv)
        }
        data <- x$get()
        inv <- solve(data)
        x$setInverse(inv)
        inv      
}
cacheSolve1(funs)



mean(mtcars$mpg)


?kernSmooth
library(KernSmooth)


str(lm)

x <- rnorm(100, 2, 4)
summary(x)
str(x)

f <- gl(40, 10)
str(f)

head(airquality)
str(airquality)

m <- matrix(rnorm(100), 10, 10)
str(m)

s <- split(airquality, airquality$Month)
s
str(s)


# generating randon numbers

# d for density
# r for random number generation
# p for cumulative distribution 
# q for quantile function 


dnorm(x, mean = 0, sd = 1, log=F)

x <- rnorm(10)
x

x <- rnorm(10, 20, 2)
summary(x)


# generating random numbers from a linear model 

# y=B0+B1x+e
# e~N(0, 2^2), x~N(0, 1^2), BO=0.5, B1=2

set.seed(20)
x <- rnorm(100)
e <- rnorm(100, 0, 2)

y <- 0.5+2*x+e
summary(y)
plot(x, y)

# x is binary
set.seed(10)
x <- rbinom(100, 1, 0.5)
e <- rnorm(100, 0, 2)
y <- 0.5+2*x+e
summary(y)
plot(x, y)


# Y~Poisson(u)
# log u = B0+B1x, BO=0.5, B1=0.3

set.seed(1)
x <- rnorm(100)
log.mu <- 0.5+0.3*x
y <- rpois(100, exp(log.mu))
summary(y)
plot(x,y)


# random sampling 

set.seed(1)
sample(1:10, 4)
sample(letters, 5)

sample(1:10) # permutation

sample(1:10, replace = T) # 복원추출


# profiling 
# system.time()

system.time(readLines("http://www.jhsph.edu"))

hilbert <- function(n) {
        i <- 1:n
        1/outer(i-1,i,"+")
}
x <- hilbert(1000)
system.time(svd(x)) # elapsed time : 코드의 총 소요시간. 통상적으로 얘기하는 코드 수행시간에 해당 



# time longer expression 

system.time({
        n <- 1000
        r <- numeric(n)
        for (i in 1:n) {
                x <- rnorm(n)
                r[i] <- mean(x)
        }
})



# rprof : 프로그램의 동적인 성능 즉, 메모리나 CPU 사용량을 평가하는 작업을 코드 프로파일링이라 함 

# Rprof(
# 프로파일링 정보를 저장할 파일. 파일명이 지정되면 프로파일링이 시작되고
# NULL이 지정되면 프로파일링이 중단된다.
#        filename="Rprof.out",
#        append=FALSE,  # 결과 파일에 프로파일링 정보를 덧붙일지 여부. FALSE면 파일을 덮어쓴다.
#        interval=0.02  # 프로파일링을 위한 샘플을 채취하는 시간 간격
#)

# by.self : 해당 함수가 온전히 사용한 시간
# by.total : 해당 함수와 호출된 함수 모두에서 사용된 시간 
# sample.interval : 표본 측정시간
# sampling.time : 프로파일링을 통해 수행된 전체 시간


# summaryRprof(
#        filename  # 프로파일링 정보가 저장된 파일
#)
# 반환 값은 프로파일링 결과를 담은 리스트다.



# example

##========================================================================
## 다이아몬드 데이터
##========================================================================
# 1. 텍스트 정보
library(carData)
Rprof(tmp <- tempfile())
data("diamonds")
# 1. 산점도
plot(price ~ carat, data=diamonds)
# 2. 선형모형 적합
lm.m <- lm(price ~ carat, data=diamonds)
# 3. 데이터와 모형 적합 평가
abline(lm.m, col = "blue")
Rprof()

summaryRprof(tmp)

# 2. 시각화
library(profr)
library(ggplot2)
x = profr(source("diamonds-prof-ex.R"))
ggplot(x)

# system.time과 Rprof 함께 사용 x

lm(y~x)
sample.interval=10000

set.seed(1)
rpois(5,2)

set.seed(10)
x <- rep(0:1, each = 5)
e <- rnorm(10, 0, 20)
y <- 0.5 + 2 * x + e

library(datasets)
Rprof()
fit <- lm(y ~ x1 + x2)
Rprof(NULL)
