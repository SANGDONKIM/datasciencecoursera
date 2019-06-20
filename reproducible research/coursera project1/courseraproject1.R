
setwd("C:/Users/sangdon/Desktop/datasciencecoursera/reproducible research")

list.files("./reproducible research")

if (!file.exists("data")) {
        dir.create("data")
}

Url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
download.file(Url, destfile = "./data/monitoringdata.zip", method = "curl")
unzip( "./data/monitoringdata.zip", exdir = "./data")

act <- read.csv("./data/activity.csv")

head(act)

# steps: number of steps taking in a 5-minute interval(missing value code as NA)
# data: the date on which the measurement was taken in YYYY-MM-DD format 
# interval: identifier for the 5-minute interval in which measurement was taken 