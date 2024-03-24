# Library
### Count
install.packages("plyr")
library(plyr)
### Json reader
install.packages("jsonlite")
library(jsonlite)
### HTTP request
install.packages("httr")
library(httr)

# Utils function
### Split function
split.data <- function(data, p = 0.7, s = 1) {
    set.seed(s)
    index <- sample(seq_len(dim(data)[1]))
    train <- data[index[1:floor(dim(data)[1] * p)], ]
    test <- data[index[((ceiling(dim(data)[1] * p)) + 1):dim(data)[1]], ]
    return(list(train = train, test = test))
}

# Data Import
if (!file.exists("waterQuality1.csv")) {
  
  kaggle_credentials <- jsonlite::fromJSON("kaggle.json")
  username <- kaggle_credentials$username
  key <- kaggle_credentials$key
  
  Sys.setenv(KAGGLE_USERNAME = username)
  Sys.setenv(KAGGLE_KEY = key)
  
  dataset <- httr::GET("https://www.kaggle.com/api/v1/datasets/download/mssmartypants/water-quality?datasetVersionNumber=3",
                       httr::authenticate(username, key, type = "basic"))
  
  temp <- tempfile()
  download.file(dataset$url,temp)
  dataset <- read.csv(unz(temp, "waterQuality1.csv"), na.strings = c("#NUM!"))
  write.csv(dataset, destination_file, row.names = FALSE)
  unlink(temp)
  
}else{
  dataset <- read.csv("waterQuality1.csv", na.strings = c("#NUM!"))
}


# Data Cleaning
## Casting
dataset$ammonia <- as.numeric(dataset$ammonia)
dataset$is_safe <- factor(dataset$is_safe)
## Removing rows with null values
count(is.na.data.frame(dataset))
dataset <- dataset[complete.cases(dataset), ]
## Delete duplicate rows
dataset <- unique(dataset)

# wrong
negative_rows <- which(dataset$ammonia < 0)
print(length(negative_rows))
dataset <- subset(dataset, ammonia >= 0)

# Splitting dataset ~ Train & Test
allset <- split.data(dataset, p = 0.7)
trainset <- allset$train
testset <- allset$test
