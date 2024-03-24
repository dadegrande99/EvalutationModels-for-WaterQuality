# Library
## Caret ~ ggplot
install.packages("caret")
library(caret)
## reshape
install.packages("reshape2")
library(reshape2)

# Utils function
### Get lower triangle of the correlation matrix
get_lower_tri <- function(cormat) {
    cormat[upper.tri(cormat)] <- NA
    return(cormat)
}
### Get upper triangle of the correlation matrix
get_upper_tri <- function(cormat) {
    cormat[lower.tri(cormat)] <- NA
    return(cormat)
}
### Use correlation between variables as distance
reorder_cormat <- function(cormat) {
    dd <- as.dist((1 - cormat) / 2)
    hc <- hclust(dd)
    cormat <- cormat[hc$order, hc$order]
}



# EDA ~ Dataset

## Summary  Information
dim(dataset)
str(dataset)
summary(dataset)

### Variance
for (i in colnames(dataset[, -21])) {
    print(var(dataset[i]))
}

### Correlation table
cormat <- round(cor(dataset[, -21]), 2)
cormat <- reorder_cormat(cormat)
upper_tri <- get_upper_tri(cormat)
melted_cormat <- melt(upper_tri, na.rm = TRUE)
ggplot(data = melted_cormat, aes(Var2, Var1, fill = value)) +
    geom_tile(color = "white") +
    scale_fill_gradient2(
        low = "blue", high = "red", mid = "white",
        midpoint = 0, limit = c(-1, 1), space = "Lab"
    ) +
    theme_minimal() +
    theme(axis.text.x = element_text(
        angle = 45, vjust = 1,
        size = 12, hjust = 1
    )) +
    coord_fixed() +
    geom_text(aes(Var2, Var1, label = value), color = "black", size = 4) +
    theme(
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        panel.grid.major = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        axis.ticks = element_blank(),
        legend.justification = c(1, 0),
        legend.position = c(0.6, 0.7),
        legend.direction = "horizontal"
    ) +
    guides(fill = guide_colorbar(
        barwidth = 7, barheight = 1,
        title.position = "top", title.hjust = 0.5
    ))

## all boxplot
par(mfrow = c(4, 5))
for (i in colnames(dataset[, -21])) {
    boxplot(dataset[i], main = i)
}
par(mfrow = c(1, 1))

## all hist
par(mfrow = c(4, 5))
for (i in colnames(dataset[, -21])) {
    hist(x = dataset[, i], probability = TRUE, col = "lightblue", border = "white", main = i, xlab = NA)
    density_values <- density(dataset[, i])
    lines(density_values, col = "blue")
}
par(mfrow = c(1, 1))


## Plot
## density
featurePlot(dataset[, 1:20], dataset$is_safe, plot = "density", scales = list(x = list(relation = "free"), y = list(relation = "free")), auto.key = list(columns = 2), pch = NA)
## boxplot
featurePlot(dataset[, 1:20], dataset$is_safe, plot = "box", scales = list(x = list(relation = "free"), y = list(relation = "free")), auto.key = list(columns = 2))

print(count(dataset$is_safe))

# Distribution of safe samples ~ Dataset
percentage_of_not_safe <- round(((count(dataset$is_safe)$freq[1]) / dim(dataset)[1]) * 100, 2)
percentage_of_safe <- round(((count(dataset$is_safe)$freq[2]) / dim(dataset)[1]) * 100, 2)
label1 <- paste0("Is not safe = ", percentage_of_not_safe, "%")
label2 <- paste0("Is safe = ", percentage_of_safe, "%")
pie(table(dataset$is_safe), labels = c(label1, label2), main = "Distribuzione dei campioni sicuri ~ Dataset", col = c("#EDD622", "#528AEE"))



# EDA ~ Training Set
dim(trainset)
str(trainset)
summary(trainset)

### Variance
for (i in colnames(trainset[, -21])) {
    print(var(trainset[i]))
}

### Correlation table
cormat <- round(cor(trainset[, -21]), 2)
cormat <- reorder_cormat(cormat)
upper_tri <- get_upper_tri(cormat)
melted_cormat <- melt(upper_tri, na.rm = TRUE)
ggplot(data = melted_cormat, aes(Var2, Var1, fill = value)) +
    geom_tile(color = "white") +
    scale_fill_gradient2(
        low = "blue", high = "red", mid = "white",
        midpoint = 0, limit = c(-1, 1), space = "Lab"
    ) +
    theme_minimal() +
    theme(axis.text.x = element_text(
        angle = 45, vjust = 1,
        size = 12, hjust = 1
    )) +
    coord_fixed() +
    geom_text(aes(Var2, Var1, label = value), color = "black", size = 4) +
    theme(
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        panel.grid.major = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        axis.ticks = element_blank(),
        legend.justification = c(1, 0),
        legend.position = c(0.6, 0.7),
        legend.direction = "horizontal"
    ) +
    guides(fill = guide_colorbar(
        barwidth = 7, barheight = 1,
        title.position = "top", title.hjust = 0.5
    )) +
    ggtitle("Plot of length \n by dose")


## all boxplot
par(mfrow = c(4, 5))
for (i in colnames(trainset[, -21])) {
    boxplot(trainset[i], main = i)
}
par(mfrow = c(1, 1))

## all hist
par(mfrow = c(4, 5))
for (i in colnames(trainset[, -21])) {
    hist(x = trainset[, i], probability = TRUE, col = "lightblue", border = "white", main = i, xlab = NA)
    density_values <- density(trainset[, i])
    lines(density_values, col = "blue")
}
par(mfrow = c(1, 1))


## Plot
## density
featurePlot(trainset[, 1:20], trainset$is_safe, plot = "density", scales = list(x = list(relation = "free"), y = list(relation = "free")), auto.key = list(columns = 2), pch = NA)
## boxplot
featurePlot(trainset[, 1:20], trainset$is_safe, plot = "box", scales = list(x = list(relation = "free"), y = list(relation = "free")), auto.key = list(columns = 2))

print(count(trainset$is_safe))

### Distribution of safe samples ~
percentage_of_not_safe <- round(((count(trainset$is_safe)$freq[1]) / dim(trainset)[1]) * 100, 2)
percentage_of_safe <- round(((count(trainset$is_safe)$freq[2]) / dim(trainset)[1]) * 100, 2)
label1 <- paste0("Is not safe = ", percentage_of_not_safe, "%")
label2 <- paste0("Is safe = ", percentage_of_safe, "%")
pie(table(trainset$is_safe), labels = c(label1, label2), main = "Distribuzione dei campioni sicuri ~ Training Set", col = c("#EDD622", "#528AEE"))

# -------------------- Principal Component Analysis (PCA) --------------------

# Library
## PCA ~ FactoMineR & factoextra
install.packages(c("FactoMineR", "factoextra"))
library("FactoMineR")
library("factoextra")


trainset2.active <- trainset[, c(1:20)]

res.pca <- PCA(trainset2.active, scale.unit = TRUE, ncp = 8, graph = TRUE)

### autovalori
eig.val <- get_eigenvalue(res.pca)
eig.val
fviz_eig(res.pca,
    addlabels = TRUE, ncp = dim(trainset2.active)[2],
    linecolor = "#FC4E07", barcolor = "#00AFBB", barfill = "#00AFBB"
)

### variabili
var <- get_pca_var(res.pca)
var
print(var$coord)
print(var$contrib)
fviz_pca_var(res.pca, col.var = "black")

### individui
ind <- get_pca_ind(res.pca)
ind
fviz_pca_ind(res.pca)
fviz_pca_ind(res.pca, col.ind = "cos2", gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), label = "none")

### biplot
fviz_pca_biplot(res.pca, col.ind = "cos2", gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), label = "var")
