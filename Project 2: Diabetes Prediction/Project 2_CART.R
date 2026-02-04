
## IMPORT CSV AND PACKAGES
setwd('/Users/Emmaq/Desktop/BC2406/Project Requirements and Guidelines/archive')

library(data.table)
library(rpart)
library(rpart.plot)	
library(ggplot2)
library(caTools)
library(caret)

diabetes <- fread("diabetes_binary_health_indicators_BRFSS2015.csv")
diabetes5050 <- fread("diabetes_binary_5050split_health_indicators_BRFSS2015.csv")

## DATA PREPARATION
diabetes$Diabetes_binary <- factor(diabetes$Diabetes_binary)
diabetes$HighBP <- factor(diabetes$HighBP)
diabetes$HighChol <- factor(diabetes$HighChol)
diabetes$CholCheck <- factor(diabetes$CholCheck)
diabetes$Smoker <- factor(diabetes$Smoker)
diabetes$Stroke <- factor(diabetes$Stroke)
diabetes$HeartDiseaseorAttack <- factor(diabetes$HeartDiseaseorAttack)
diabetes$PhysActivity <- factor(diabetes$PhysActivity)
diabetes$Fruits <- factor(diabetes$Fruits)
diabetes$Veggies <- factor(diabetes$Veggies)
diabetes$HvyAlcoholConsump <- factor(diabetes$HvyAlcoholConsump)
diabetes$AnyHealthcare <- factor(diabetes$AnyHealthcare)
diabetes$NoDocbcCost <- factor(diabetes$NoDocbcCost)
diabetes$GenHlth <- factor(diabetes$GenHlth,
                            levels = c(1,2,3,4,5))
diabetes$DiffWalk <- factor(diabetes$DiffWalk)
diabetes$Sex <- factor(diabetes$Sex,
                       labels = c("F","M"))
diabetes$Age <- factor(diabetes$Age,
                        levels = c(1,2,3,4,5,6,7,8,9,10,11,12,13))
diabetes$Education <- factor(diabetes$Education,
                             levels = c(1,2,3,4,5,6))
diabetes$Income <- factor(diabetes$Income,
                              levels = c(1,2,3,4,5,6,7,8))



diabetes5050$Diabetes_binary <- factor(diabetes5050$Diabetes_binary)
diabetes5050$HighBP <- factor(diabetes5050$HighBP)
diabetes5050$HighChol <- factor(diabetes5050$HighChol)
diabetes5050$CholCheck <- factor(diabetes5050$CholCheck)
diabetes5050$Smoker <- factor(diabetes5050$Smoker)
diabetes5050$Stroke <- factor(diabetes5050$Stroke)
diabetes5050$HeartDiseaseorAttack <- factor(diabetes5050$HeartDiseaseorAttack)
diabetes5050$PhysActivity <- factor(diabetes5050$PhysActivity)
diabetes5050$Fruits <- factor(diabetes5050$Fruits)
diabetes5050$Veggies <- factor(diabetes5050$Veggies)
diabetes5050$HvyAlcoholConsump <- factor(diabetes5050$HvyAlcoholConsump)
diabetes5050$AnyHealthcare <- factor(diabetes5050$AnyHealthcare)
diabetes5050$NoDocbcCost <- factor(diabetes5050$NoDocbcCost)
diabetes5050$GenHlth <- factor(diabetes5050$GenHlth,
                           levels = c(1,2,3,4,5))
diabetes5050$DiffWalk <- factor(diabetes5050$DiffWalk)
diabetes5050$Sex <- factor(diabetes5050$Sex,
                       labels = c("F","M"))
diabetes5050$Age <- factor(diabetes5050$Age,
                       levels = c(1,2,3,4,5,6,7,8,9,10,11,12,13))
diabetes5050$Education <- factor(diabetes5050$Education,
                             levels = c(1,2,3,4,5,6))
diabetes5050$Income <- factor(diabetes5050$Income,
                          levels = c(1,2,3,4,5,6,7,8))



## EXPLORING DATASET
head(diabetes)
summary(diabetes)
str(diabetes)



### TRAIN-TEST SPLIT 

## diabetes.csv
set.seed(123)

train <- sample.split(Y = diabetes$Diabetes_binary, SplitRatio = 0.7)
trainset <- subset(diabetes, train == T)
testset <- subset(diabetes, train == F)

summary(trainset$Diabetes_binary)
summary(testset$Diabetes_binary)


## diabetes5050.csv
train2 <- sample.split(Y = diabetes5050$Diabetes_binary, SplitRatio = 0.7)
trainset2 <- subset(diabetes5050, train2 == T)
testset2 <- subset(diabetes5050, train2 == F)

summary(trainset2$Diabetes_binary)
summary(testset2$Diabetes_binary)


### CART models

# define trees
max_tree <- rpart(Diabetes_binary ~ ., data = trainset, method = 'class',
                  control = rpart.control(cp = 0.0005))

max_tree2 <- rpart(Diabetes_binary ~ ., data = trainset2, method = 'class',
                   control = rpart.control(cp = 0.0005))

# plot tree
rpart.plot(max_tree, nn= T, main = "Maximal Tree (diabetes.csv)", fallen.leaves = TRUE)

rpart.plot(max_tree2, nn= T, main = "Maximal Tree (Diabetes5050.csv)", fallen.leaves = TRUE)

# stats of max tree
summary(max_tree)

summary(max_tree2)

# print cp
printcp(max_tree)
plotcp(max_tree, main = "Subtrees in diabetes.csv")

printcp(max_tree2)
plotcp(max_tree2, main = "Subtrees in diabetes5050.csv")

# pruning the tree
cp1 <- 0.0026
pruned_tree <- prune(max_tree, cp = cp1)
rpart.plot(pruned_tree, nn= T, main = "Pruned Tree with cp = 0.0026 (Diabetes.csv)")
summary(pruned_tree)

cp2 = 0.00092
pruned_tree2 <- prune(max_tree2, cp = cp2)
rpart.plot(pruned_tree2, nn= T, main = "Pruned Tree (5050 dataset) with cp = 0.00092")
summary(pruned_tree2)

# prediction
predict_cart <- predict(pruned_tree, newdata=testset, type = "class")
confusion <- confusionMatrix(testset$Diabetes_binary, predict_cart, positive = "1")
confusion

predict_cart2 <- predict(pruned_tree2, newdata=testset, type = "class")
confusion2 <- confusionMatrix(testset$Diabetes_binary, predict_cart2, positive = "1")
confusion2

# save final model to be used in prototype
saveRDS(pruned_tree2, "cart_model.rds")
