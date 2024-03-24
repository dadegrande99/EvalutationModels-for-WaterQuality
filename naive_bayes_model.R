# -------------------------------- Naive Bayes --------------------------------

# Library
install.packages("naivebayes")
library(naivebayes)

nb_classifier <- naive_bayes(trainset[1:20], trainset$is_safe, usepoisson = FALSE, usekernel = FALSE)
nb_test.predicted <- predict(nb_classifier, testset[1:20])
nb.table <- table(testset$is_safe, nb_test.predicted)
nb.table
