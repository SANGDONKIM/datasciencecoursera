setwd("C:/Users/sangdon/Desktop/R/coursera_datascience/rprog_data_ProgAssignment3-data")
library(tidyverse)


hospital <- read.csv("hospital-data.csv")
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

glimpse(outcome)

ncol(outcome)


# plot the 30-day mortality rates for heart attack

outcome[ ,11] <- as.numeric(outcome[ ,11])
hist(outcome[, 11])


# finding the best hospital in a rate 
# 두개의 인수를 갖는 best 함수를 작성.
# 30일 간 사망비율이 가장 낮은 최고의 병원을 뽑아서 character vector로 반환.
# 병원 이름은 Hospital.Name 변수임.
# outcome은 "heart attack", "heart failure", "pneumonia" 중 하나임.
# outcome에 값이 없는 경우 순위에서 배제함. 
# 동점일 경우 알파벳 순서로 sort 됨. 
DT::datatable(outcome[ ,c(2, 7, 11, 17, 23)])
# outcome[, 2] : hospital name  
# outcome[, 7] : state
# outcome[, 11] : heart attack death rate
# outcome[, 17] : heart failure death rate 
# outcome[, 23] : pneumonia death rate 


best <- function(state, outcome) {
        
        outcome_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        outcome_subset <- outcome_data[ ,c(2, 7, 11, 17, 23)]
        colnames(outcome_subset) <- c("hospital.name", "State", "heartattack", "heartfailure", "pneumonia")
        outcome_subset[outcome_subset=="Not Available"] <- NA
        
        for (i in 3:5) {
                outcome_subset[,i] <- as.numeric(outcome_subset[,i])
        }
        
        if (!state%in%outcome_subset[outcome_subset$State=="state", ]) {
                stop("invalid state")
        } else if (!outcome%in%c("heartattack", "heartfaliure", "pneumonia")) {
                stop("invalid outcome")
        }
        else {
                
                filter_data <- outcome_subset %>% filter(State=="state")
                
                min_value <- min(filter_data[, outcome], na.rm = T)
                
                final_result <- filter_data[, "hospital.name"][which(filter_data[, outcome]==min_value)]
                best_hospital <- final_result[order(final_result)]
        }
        best_hospital
}

best("TX", "heartattack")




library("data.table")
library(bit64)
# Reading in data
outcome <- data.table::fread('outcome-of-care-measures.csv')
outcome[, (11) := lapply(.SD, as.numeric), .SDcols = (11)]
outcome[, lapply(.SD
                 , hist
                 , xlab= "Deaths"
                 , main = "Hospital 30-Day Death (Mortality) Rates from Heart Attack"
                 , col="lightblue")
        , .SDcols = (11)]



best <- function(state, outcome) {
        
        # Read outcome data
        out_dt <- data.table::fread('outcome-of-care-measures.csv')
        
        outcome <- tolower(outcome)
        
        # Column name is same as variable so changing it 
        chosen_state <- state 
        
        # Check that state and outcome are valid
        if (!chosen_state %in% unique(out_dt[["State"]])) {
                stop('invalid state')
        }
        
        if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
                stop('invalid outcome')
        }
        
        # Renaming Columns to be less verbose and lowercase
        setnames(out_dt
                 , tolower(sapply(colnames(out_dt), gsub, pattern = "^Hospital 30-Day Death \\(Mortality\\) Rates from ", replacement = "" ))
        )
        
        #Filter by state
        out_dt <- out_dt[state == chosen_state]
        
        # Columns indices to keep
        col_indices <- grep(paste0("hospital name|state|^",outcome), colnames(out_dt))
        
        # Filtering out unnessecary data 
        out_dt <- out_dt[, .SD ,.SDcols = col_indices]
        
        # Find out what class each column is 
        # sapply(out_dt,class)
        out_dt[, outcome] <- out_dt[,  as.numeric(get(outcome))]
        
        
        # Removing Missing Values for numerical datatype (outcome column)
        out_dt <- out_dt[complete.cases(out_dt),]
        
        # Order Column to Top 
        out_dt <- out_dt[order(get(outcome), `hospital name`)]
        
        return(out_dt[, "hospital name"][1])
        
}


rankhospital <- function(state, outcome, num = "best") {
        
        # Read outcome data
        out_dt <- data.table::fread('outcome-of-care-measures.csv')
        
        outcome <- tolower(outcome)
        
        # Column name is same as variable so changing it 
        chosen_state <- state 
        
        # Check that state and outcome are valid
        if (!chosen_state %in% unique(out_dt[["State"]])) {
                stop('invalid state')
        }
        
        if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
                stop('invalid outcome')
        }
        
        # Renaming Columns to be less verbose and lowercase
        setnames(out_dt
                 , tolower(sapply(colnames(out_dt), gsub, pattern = "^Hospital 30-Day Death \\(Mortality\\) Rates from ", replacement = "" ))
        )
        
        #Filter by state
        out_dt <- out_dt[state == chosen_state]
        
        # Columns indices to keep
        col_indices <- grep(paste0("hospital name|state|^",outcome), colnames(out_dt))
        
        # Filtering out unnessecary data 
        out_dt <- out_dt[, .SD ,.SDcols = col_indices]
        
        # Find out what class each column is 
        # sapply(out_dt,class)
        out_dt[, outcome] <- out_dt[,  as.numeric(get(outcome))]
        
        
        # Removing Missing Values for numerical datatype (outcome column)
        out_dt <- out_dt[complete.cases(out_dt),]
        
        # Order Column to Top 
        out_dt <- out_dt[order(get(outcome), `hospital name`)]
        
        out_dt <- out_dt[,  .(`hospital name` = `hospital name`, state = state, rate = get(outcome), Rank = .I)]
        
        if (num == "best"){
                return(out_dt[1,`hospital name`])
        }
        
        if (num == "worst"){
                return(out_dt[.N,`hospital name`])
        }
        
        return(out_dt[num,`hospital name`])
        
}


rankall <- function(outcome, num = "best") {
        
        # Read outcome data
        out_dt <- data.table::fread('outcome-of-care-measures.csv')
        
        outcome <- tolower(outcome)
        
        if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
                stop('invalid outcome')
        }
        
        # Renaming Columns to be less verbose and lowercase
        setnames(out_dt
                 , tolower(sapply(colnames(out_dt), gsub, pattern = "^Hospital 30-Day Death \\(Mortality\\) Rates from ", replacement = "" ))
        )
        
        # Columns indices to keep
        col_indices <- grep(paste0("hospital name|state|^",outcome), colnames(out_dt))
        
        # Filtering out unnessecary data 
        out_dt <- out_dt[, .SD ,.SDcols = col_indices]
        
        # Find out what class each column is 
        # sapply(out_dt,class)
        
        # Change outcome column class
        out_dt[, outcome] <- out_dt[,  as.numeric(get(outcome))]
        
        if (num == "best"){
                return(out_dt[order(state, get(outcome), `hospital name`)
                              , .(hospital = head(`hospital name`, 1))
                              , by = state])
        }
        
        if (num == "worst"){
                return(out_dt[order(get(outcome), `hospital name`)
                              , .(hospital = tail(`hospital name`, 1))
                              , by = state])
        }
        
        return(out_dt[order(state, get(outcome), `hospital name`)
                      , head(.SD,num)
                      , by = state, .SDcols = c("hospital name") ])
        
}

best("SC", "heart attack")
best("NY", "pneumonia")
best("AK", "pneumonia")
rankhospital("NC", "heart attack", "worst")
rankhospital("WA", "heart attack", 7)
rankhospital("TX", "pneumonia", 10)
rankhospital("NY", "heart attack", 7)

r <- rankall("heart attack", 4)
as.character(subset(r, state == "HI")$hospital)


r <- rankall("pneumonia", "worst")
as.character(subset(r, state == "NJ")$hospital)

r <- rankall("heart failure", 10)
as.character(subset(r, state == "NV")$hospital)


# CRAN version
install.packages('tinytex')

# or the development version on Github
devtools::install_github('yihui/tinytex')

devtools::install_github('yihui/tinytex')
options(tinytex.verbose = TRUE)
library(tinytex)

tinytex::install_tinytex()




