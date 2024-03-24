# Main File - Evaluation of Machine Learning models for water quality classification

# Load required libraries
install.packages("plyr")
library(plyr)
install.packages("caret")
library(caret)
install.packages("reshape2")
library(reshape2)
install.packages("FactoMineR")
library(FactoMineR)
install.packages("factoextra")
library(factoextra)
install.packages("rpart")
library(rpart)
install.packages("rattle")
library(rattle)
install.packages("rpart")
library(rpart.plot)
install.packages("RColorBrewer")
library(RColorBrewer)
install.packages("e1071")
library(e1071)
install.packages("naivebayes")
library(naivebayes)
install.packages("ROCR")
library(ROCR)
install.packages("pROC")
library(pROC)
install.packages("kernlab")
library(kernlab)

# Source other files

## Execute data import and cleaning
source("data_import_cleaning.R")

## Perform exploratory data analysis
source("eda.R")

## Train and evaluate decision tree model
source("decision_tree_model.R")

## Train and evaluate SVM model
source("svm_model.R")

## Train and evaluate Naive Bayes model
source("naive_bayes_model.R")

## Evaluate model performance
source("performance_evaluation.R")

## Perform cross-validation
source("cross_validation.R")
