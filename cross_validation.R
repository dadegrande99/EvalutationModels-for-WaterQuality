# ------------------------- 10-Fold-Cross-Validation -------------------------

# Library
### kernlab
install.packages("kernlab")
library("kernlab")


levels(testset$is_safe) <- c("no", "yes")
levels(dataset$is_safe) <- c("no", "yes")


control <- trainControl(method = "repeatedcv", number = 10, repeats = 3, classProbs = TRUE, summaryFunction = twoClassSummary)

### Training
svm.model <- train(is_safe ~ ., data = dataset, method = "svmLinear", metric = "ROC", trControl = control)
dt.model <- train(is_safe ~ ., data = dataset, method = "rpart", metric = "ROC", trControl = control)
nb.model <- train(is_safe ~ ., data = dataset, method = "naive_bayes", metric = "ROC", trControl = control)

### Prediction with probability
svm.probs <- predict(svm.model, testset[, !names(testset) %in% c("is_safe")], type = "prob")
dt.probs <- predict(dt.model, testset[, !names(testset) %in% c("is_safe")], type = "prob")
nb.probs <- predict(nb.model, testset[, !names(testset) %in% c("is_safe")], type = "prob")

## Plotting
### SVM
svm.ROC <- roc(
    response = testset[, c("is_safe")], predictor = svm.probs$yes,
    levels = levels(testset[, c("is_safe")])
)
plot(svm.ROC, type = "S", col = "green")
### DT
dt.ROC <- roc(
    response = testset[, c("is_safe")], predictor = dt.probs$yes,
    levels = levels(testset[, c("is_safe")])
)
plot(dt.ROC, add = TRUE, col = "blue")
### NB
nb.ROC <- roc(
    response = testset[, c("is_safe")], predictor = nb.probs$yes,
    levels = levels(testset[, c("is_safe")])
)
plot(nb.ROC, add = TRUE, col = "red")
legend("topright", c("SVM", "Decision Tree", "Naive Bayes"),
    col = c("green", "blue", "red"), pch = c(16), bty = "n"
)

## Compare AUC
print(paste("SVM ~ AUC:", svm.ROC$auc))
print(paste("Decision Tree ~ AUC:", dt.ROC$auc))
print(paste("Naive Bayes ~ AUC:", nb.ROC$auc))

# Compare models
cv.values <- resamples(list(SVM = svm.model, DecisionTree = dt.model, NaiveBayes = nb.model))
summary(cv.values)
print(cv.values$timings)
## Plotting
dotplot(cv.values, metric = "ROC")
bwplot(cv.values, layout = c(3, 1))
