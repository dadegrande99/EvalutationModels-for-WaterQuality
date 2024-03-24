# -------------------------- Performance Evalutation --------------------------

# Library
## ROCR
install.packages("ROCR")
library(ROCR)
## pROC
install.packages("pROC")
library(pROC)

# Utils function
opt.cut <- function(perf, pred) {
    mapply(FUN = function(x, y, p) {
        d <- (x - 0)^2 + (y - 1)^2
        ind <- which(d == min(d))
        c(
            sensitivity = y[[ind]], specificity = 1 - x[[ind]],
            cutoff = p[[ind]]
        )
    }, perf@x.values, perf@y.values, pred@cutoffs)
}


# Performance
## SVM
print("Support Vector Machine")
print(confusionMatrix(svm.pred, testset$is_safe, mode = "everything", positive = "1"))
## DT
print("Decision Tree")
print(confusionMatrix(Prediction, testset$is_safe, mode = "everything", positive = "1"))
## NB
print("Naive Bayes")
print(confusionMatrix(nb_test.predicted, testset$is_safe, mode = "everything", positive = "1"))


# ROC ~ AUC & cut-off

## SVM
pred <- predict(svm.model, testset[, !names(testset) %in% c("is_safe")], probability = TRUE)
pred.prob <- attr(pred, "probabilities")
pred.to.roc <- pred.prob[, 2]
pred.rocr <- prediction(pred.to.roc, testset$is_safe)
perf.rocr <- performance(pred.rocr, measure = "auc", x.measure = "cutoff")
perf.tpr.rocr <- performance(pred.rocr, "tpr", "fpr")
## Plot
plot(perf.tpr.rocr, colorize = T, main = paste("Support Vector Machine ROC Curve \n AUC:", (perf.rocr@y.values)))
abline(a = 0, b = 1)

## cut-off
print(opt.cut(perf.tpr.rocr, pred.rocr))
acc.perf <- performance(pred.rocr, measure = "acc")
### Plot
plot(acc.perf)
### Values
ind <- which.max(slot(acc.perf, "y.values")[[1]])
acc <- slot(acc.perf, "y.values")[[1]][ind]
cutoff <- slot(acc.perf, "x.values")[[1]][ind]
print(c(accuracy = acc, cutoff = cutoff))


## Decision Tree
### probability prediction
tree_prob <- predict(prunedDecisionTree, newdata = testset[1:20], type = "prob")
tree_pred <- prediction(tree_prob[, 2], testset$is_safe)
### performance
tree_perf <- performance(tree_pred, measure = "auc", x.measure = "cutoff")
tree_perf.tpr <- performance(tree_pred, "tpr", "fpr")
## Plot
plot(tree_perf.tpr, colorize = T, main = paste("Decision Tree ROC Curve \n AUC:", (tree_perf@y.values)))
abline(a = 0, b = 1)

## cut-off
print(opt.cut(tree_perf.tpr, tree_pred))
acc.perf <- performance(tree_pred, measure = "acc")
### Plot
plot(acc.perf)
### Values
ind <- which.max(slot(acc.perf, "y.values")[[1]])
acc <- slot(acc.perf, "y.values")[[1]][ind]
cutoff <- slot(acc.perf, "x.values")[[1]][ind]
print(c(accuracy = acc, cutoff = cutoff))

## Naive Bayes
### probability prediction
nb_prob <- predict(nb_classifier, testset[1:20], type = "prob")
nb_pred <- prediction(nb_prob[, 2], testset$is_safe)
### performance
nb_perf <- performance(nb_pred, measure = "auc", x.measure = "cutoff")
nb_perf.tpr <- performance(nb_pred, "tpr", "fpr")
## Plot
plot(nb_perf.tpr, colorize = T, main = paste("Naive Bayes ROC Curve \n AUC:", (nb_perf@y.values)))
abline(a = 0, b = 1)

## cut-off
print(opt.cut(nb_perf.tpr, nb_pred))
acc.perf <- performance(nb_pred, measure = "acc")
### Plot
plot(acc.perf)
### Values
ind <- which.max(slot(acc.perf, "y.values")[[1]])
acc <- slot(acc.perf, "y.values")[[1]][ind]
cutoff <- slot(acc.perf, "x.values")[[1]][ind]
print(c(accuracy = acc, cutoff = cutoff))
