# ---------------------------- Decision Tree (DT) ----------------------------
# Library
### rpart
install.packages("rpart")
library("rpart")
### rattle
install.packages("rattle")
library("rattle")
### rpart.plot
install.packages("rpart.plot")
library("rpart.plot")
### RColorBrewer
install.packages("RColorBrewer")
library("RColorBrewer")


## DT
decisionTree <- rpart(is_safe ~ ., data = trainset, method = "class")

## Plot
### "Spartan" plot
plot(decisionTree)
text(decisionTree)
### "aesthetic" plot
fancyRpartPlot(decisionTree)

## Prediction
Prediction <- predict(decisionTree, testset[1:20], type = "class")

### Accuracy
confusion.matrix <- table(testset$is_safe, Prediction)
sum(diag(confusion.matrix)) / sum(confusion.matrix)

### Summary information
summary(decisionTree)
### Complexity Parameter
printcp(decisionTree)
plotcp(decisionTree)


## Searching Best CP
tmp <- data.frame(printcp(decisionTree))
i <- 1
for (c in (2:(dim(tmp)[2]))) {
    if (tmp$xerror[c] < tmp$xerror[i]) {
        i <- c
    }
}
BestCP <- tmp$CP[i]

## Changing DT ~ prune
prunedDecisionTree <- prune(decisionTree, cp = BestCP)
fancyRpartPlot(prunedDecisionTree)
### Prediction & Summary information of new DT
Prediction <- predict(prunedDecisionTree, testset, type = "class")
### Accuracy
confusion.matrix <- table(testset$is_safe, Prediction)
sum(diag(confusion.matrix)) / sum(confusion.matrix)
### Summary information
summary(prunedDecisionTree)

## forecast result
percentage_of_not_safe <- round(((count(Prediction)$freq[1]) / dim(testset)[1]) * 100, 2)
percentage_of_safe <- round(((count(Prediction)$freq[2]) / dim(testset)[1]) * 100, 2)
label1 <- paste0("Is not safe = ", percentage_of_not_safe, "%")
label2 <- paste0("Is safe = ", percentage_of_safe, "%")
pie(table(Prediction), labels = c(label1, label2), main = "Distribuzione dei campioni sicuri", col = c("#EDD622", "#528AEE"))
