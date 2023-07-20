# LIBRARIES
install.packages(c("ggplot2", "cowplot", "caret", "ROCR", "rpart", "rpart.plot", "rattle", "randomForest"))
install.packages(c("shiny", "shinythemes"))
library(ggplot2)
library(cowplot)
library(caret)
library(ROCR)
library(rpart)
library(rpart.plot)
library(rattle)
library(randomForest)

#  DATA
credit <- read.csv('data/german_credit.csv', header = TRUE)
str(credit)

# One thing to note immediately is that three of the columns contain continuous variables rather than categorical data (duration of credit, credit amount and age). This is potentially important information in deciding credit risk and therefore one solution is to transform the data into categorical variables using the cut function.

credit$Duration.of.Credit..month. <- cut(credit$Duration.of.Credit..month., c(0,12,18,24,Inf), labels = c(1:4))
credit$Credit.Amount <- cut(credit$Credit.Amount, c(0,1000,5000,10000,Inf), labels = c(1:4))
credit$Age..years. <- cut(credit$Age..years., c(18,25,40,60,Inf), labels = c(1:4))
head(credit[,c(3,6,14)],5)

# The new structure of the three columns can be seen above. The categories have changed as follows. Duration of Credit (month):
#   
# 0 - 12 months
# 13 - 18 months
# 19 - 24 months
# Over 24 months
# Credit Amount:
#   
# 0 - 1,000 DM
# 1,001 - 5,000 DM
# 5,001 - 10,000 DM
# Over 10,000 DM
# Age:
#   
# 18 - 25
# 26 - 40
# 41 - 60
# Over 60
# Finally, the remaining columns can be converted to factors.


for(i in 1:21) credit[, i] <- as.factor(credit[, i])

# EXPLORATORY DATA ANALYSIS
g <- ggplot(credit, aes(Creditability)) +
  geom_bar(fill = "#4EB25A") +
  theme(axis.title.x=element_blank()) + 
  theme(axis.title.y=element_blank()) +
  scale_y_continuous(breaks=seq(0,700,100)) +
  scale_x_discrete(labels = c("Bad","Good")) +
  ggtitle("Count of Good and Bad Credit Risks")
g


g <- ggplot(credit, aes(Value.Savings.Stocks, fill = Creditability), stat="identity") +
  geom_bar() +
  scale_fill_manual(values = c("#D3D6D4", "#4EB25A"), labels=c("Bad","Good")) +
  theme(axis.title.x=element_blank()) +
  theme(axis.title.y=element_blank()) +
  scale_y_continuous(breaks=seq(0,700,100)) +
  scale_x_discrete(labels = c("< 100 DM", "100-500 DM", "500-1000 DM", "> 1000 DM", "Unknown")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 10)) + 
  theme(axis.text.y = element_text(size = 10)) +
  theme(legend.text=element_text(size=10)) +
  theme(legend.title=element_text(size=12)) +
  ggtitle("Good and Bad Credit Risks by Credit History")
g


g <- ggplot(credit, aes(Occupation, fill = Creditability), stat="identity") +
  geom_bar() +
  scale_fill_manual(values = c("#D3D6D4", "#4EB25A"), labels=c("Bad","Good")) +
  theme(axis.title.x=element_blank()) +
  theme(axis.title.y=element_blank()) +
  scale_y_continuous(breaks=seq(0,700,100)) +
  scale_x_discrete(labels = c("Unemployed", "Unskilled", "Skilled", "Management")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 10)) + 
  theme(axis.text.y = element_text(size = 10)) +
  theme(legend.text=element_text(size=10)) +
  theme(legend.title=element_text(size=12)) +
  ggtitle("Good and Bad Credit Risks by Occupation")
g



g <- ggplot(credit, aes(Age..years., fill = Creditability), stat="identity") +
  geom_bar() +
  scale_fill_manual(values = c("#D3D6D4", "#4EB25A"), labels=c("Bad","Good")) +
  theme(axis.title.x=element_blank()) +
  theme(axis.title.y=element_blank()) +
  scale_y_continuous(breaks=seq(0,700,100)) +
  scale_x_discrete(labels = c("18-25", "26-40", "41-60", "60+")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 10)) + 
  theme(axis.text.y = element_text(size = 10)) +
  theme(legend.text=element_text(size=10)) +
  theme(legend.title=element_text(size=12)) +
  ggtitle("Good and Bad Credit Risks by Age")
g



#  STATISTICAL MODELING
#LOGISTIC REGRESSION
# The first step before applying models is to create training and test data sets. The data will be split 70/30 and spread evenly between good and bad credit risks using the CreateDataPartition function in the caret package.

set.seed(2828)
inTraining <- createDataPartition(credit$Creditability, p=0.7, list=FALSE)
train <- credit[inTraining,]
test <- credit[-inTraining,]

# The first model is logistic regression using the glm() function.

set.seed(2828)
lmModel <- glm(Creditability ~ ., family = binomial, data = train)

# Fit model to test set
lmFit <- predict(lmModel, type = "response", test)

# Compare predictions to test set
lmPred <- prediction(lmFit, test$Creditability)

# Create Area Under the Curve (AUC) plot
plot(performance(lmPred, 'tpr', 'fpr'))


performance(lmPred, measure = 'auc')@y.values[[1]]

## [1] 0.7868254

# The AUC of the model is 0.787. This is a measure of the model’s performance by evaluating the trade off between the true positive and false positive rate i.e. how good is the model at identifying good credit risk without falsely identifying bad risks as good?
#   
#   This is a fairly good score but the next sections will look at classification trees and random forests to try and improve on this.

# DECISION TREE

# Decision trees use a tree-like model of decisions and their outcomes to create a prediction model.

set.seed(28)
dtModel <- rpart(Creditability ~ ., data=train)
fancyRpartPlot(dtModel)


dtFit <- predict(dtModel, test, type = 'prob')[, 2]
dtPred <- prediction(dtFit, test$Creditability)
plot(performance(dtPred, 'tpr', 'fpr'))



performance(dtPred, measure = 'auc')@y.values[[1]]

## [1] 0.7090476
# This model has performed less well than logistic regression.

# RANDOM FOREST
# The final model is Random Forest. Random forests operate by constructing a number of decision trees on the training data set and outputting the class that is the mode of the classes across the decision trees.

set.seed(2828)
rfModel <- randomForest(Creditability ~ ., data=train)
rfFit <- predict(rfModel, test, type = 'prob')[,2]
rfPred <- prediction(rfFit, test$Creditability)
plot(performance(rfPred, 'tpr', 'fpr'))


performance(rfPred, measure = 'auc')@y.values[[1]]

## [1] 0.7947884
# The Random Forest model returns an AUC of 0.795 which is slightly better than the logistic regression model. This is the model which will be used for the final application.
# 
# The plot below shows the rank of importance for variables in the Random Forest model. Account balance is ranked as the most significant measurement in the model with purpose second. Purpose identifies the reason for the applicant’s request for credit e.g. car, education, business etc.

par(mfrow=c(1,1))
varImpPlot(rfModel, pch=1, main="Random Forest Model Variables Importance")


rfCM <- confusionMatrix(test$Creditability,
                        predict(rfModel, test, type="class"))
rfCM

