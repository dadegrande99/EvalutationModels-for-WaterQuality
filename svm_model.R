# ----------------------- Support Vector Machine (SVM) -----------------------

# Library
## SVM ~ e1071
install.packages("e1071")
library(e1071)

tuned <- tune.svm(is_safe ~ ., data = trainset, kernel = "linear", cost = c(0.001, 0.01, 0.1, 1, 5, 10, 50))
summary(tuned)

# il risultato migliore è il costo 5 quindi rieseguiamo su questo costo
svm.model <- svm(is_safe ~ ., data = trainset, kernel = "linear", cost = tuned$best.parameters$cost, scale = TRUE, prob = TRUE)
svm.pred <- predict(svm.model, testset[1:20])
svm.table <- table(testset$is_safe, svm.pred)
svm.table
