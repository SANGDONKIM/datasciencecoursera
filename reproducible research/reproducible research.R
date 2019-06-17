library(kernlab)
library(tidyverse)
library(GGally)
theme_set(theme_bw())
data("spam")

head(spam)


set.seed(3435)
trainIndicator=rbinom(4601, size = 1, prob = 0.5)
table(trainIndicator)

trainSpam=spam[trainIndicator==1, ]
testSpam=spam[trainIndicator==0, ]

names(trainSpam)

table(trainSpam$type)


trainSpam %>% ggplot(aes(x=type, y=capitalAve))+geom_boxplot()

# capitalAve 값에 0이 많기 때문에 변환 필요 
trainSpam %>% ggplot(aes(x=type, y=log10(capitalAve+1)))+geom_boxplot()


ggpairs(log10(trainSpam[, 1:4]+1))


# clustering 
hCluster=hclust(dist(t(trainSpam[, 1:57])))
plot(hCluster)

hClusterUpdated=hclust(dist(t(log10(trainSpam[, 1:55]+1))))
plot(hClusterUpdated)



# 공부 필요 
# statistical prediction/modeling 

trainSpam$numType=as.numeric(trainSpam$type)-1
costFunction=function(x, y) sum(x!=(y>0.5))
cvError=rep(NA,55)

library(boot)

for (i in 1:55) {
        lmFormula=reformulate(names(trainSpam)[i], response = "numType")
        glmFit=glm(lmFormula, family = "binomial", data=trainSpam)
        cvError[i]=cv.glm(trainSpam, glmFit, costFunction, 2)$delta[2]
}

## which predictor has minimum cross-valiated error?
names(trainSpam)[which.min(cvError)]


## use the best model from the group
predictionModel=glm(numType~charDollar, family="binomial", data=trainSpam)

## get predictions on the test set

predictionTest=predict(predictionModel, testSpam)
predictedSpam=rep("nonspam", dim(testSpam)[1])


## classify as 'spam' for those with prob > 0.5
predictedSpam[predictionModel$fitted.values>0.5]="spam"


# classification table
table(predictedSpam, testSpam$type)

## error rate
(61+458)/(1346+458+61+449)


# 분석 보고서 예 

# 1. 질문 
# 이메일에 대한 양적인 변수로 SPAM/HAM을 분류할 수 있는가? 

# 2. 접근방법에 대한 설명 
# UCI 저장소에서 데이터 수집 -> training/test set으로 나눔 
# 변수 간의 관계 탐색
# 교차검증을 통해 training set에서 로지스틱 모델 탐색
# test set에 적용한 결과 accuracy 78%

# 3. 결과 해석 
# number of dollor signs seems resonable, e.g "Make money with Viagra $ $ $ $!"

# 4. challenge results
# 78% isn't that great
# I could use more variables
# why logistic regression? 
