# Evaluation of Machine Learning models for water quality classification

Undergraduate project of the course [Machine Learning](https://elearning.unimib.it/course/info.php?id=44597#en) (MSc in Computer Science at [University of Study in Milan-Bicocca](https://en.unimib.it/)).

This project represents a detailed analysis and evaluation of some machine learning models for water quality classification. We focused on analyzing data from several authoritative sources, including a dataset provided by Kaggle, in order to develop and evaluate predictive models to classify water quality based on a set of relevant indicators and variables.

The primary objective of this project is to provide water experts with advanced tools for water quality management and monitoring. Through the application of machine learning techniques, we aim to ensure a safe and sustainable water supply.

Is possible to read more details about the results obtained in the [Report(IT version)](Report%20-%20IT.pdf).

## Table of contents

- [Evaluation of Machine Learning models for water quality classification](#evaluation-of-machine-learning-models-for-water-quality-classification)
  - [Table of contents](#table-of-contents)
  - [Dataset](#dataset)
    - [Goal of dataset use](#goal-of-dataset-use)
  - [Project Structure](#project-structure)
  - [File Structure](#file-structure)
  - [File Descriptions](#file-descriptions)
    - [`main.R`](#mainr)
    - [`data_import_cleaning.R`](#data_import_cleaningr)
    - [`eda.R`](#edar)
    - [`decision_tree_model.R`](#decision_tree_modelr)
    - [`svm_model.R`](#svm_modelr)
    - [`naive_bayes_model.R`](#naive_bayes_modelr)
    - [`performance_evaluation.R`](#performance_evaluationr)
    - [`cross_validation.R`](#cross_validationr)
  - [Dependencies](#dependencies)
  - [Contributors](#contributors)
  - [License](#license)

## Dataset

The dataset used in this project was obtained from [Kaggle](https://www.kaggle.com/datasets/mssmartypants/water-quality), this is a set of data created from imaginary data of water quality in an urban environment.

### Goal of dataset use

Water quality is crucial for human health and environmental sustainability. This project analyzes a dataset containing various parameters related to water quality, such as pH, ammonia levels, dissolved oxygen, etc. Machine learning models are implemented to predict water safety based on these parameters.

## Project Structure

- **Data Import and Cleaning:** Importing the dataset and preprocessing steps to clean and prepare the data for analysis.
- **Exploratory Data Analysis (EDA):** Conducting exploratory data analysis to gain insights into the dataset and understand the relationships between variables.
- **Model Implementation:** Implementing machine learning models, including decision trees, support vector machines (SVM), and Naive Bayes, for water quality classification.
- **Performance Evaluation:** Evaluating the performance of models using metrics such as accuracy, confusion matrices, and ROC curves.
- **Cross-Validation:** Performing cross-validation to assess the generalization capabilities of the models and ensure their stability.

## File Structure

The project is organized into several files for better code organization and management:

- `main.R`: The main file of the project that orchestrates the execution of other files and tasks.
- `data_import_cleaning.R`: Contains code for importing data, cleaning, and preparing it for analysis.
- `eda.R`: Includes code for exploratory data analysis (EDA), including visualizations and descriptive statistics.
- `decision_tree_model.R`: Contains code for implementing and evaluating the decision tree model.
- `svm_model.R`: Contains code for implementing and evaluating the support vector machine (SVM) model.
- `naive_bayes_model.R`: Contains code for implementing and evaluating the Naive Bayes model.
- `performance_evaluation.R`: Contains code for evaluating the performance of models, such as confusion matrix creation, accuracy calculation, ROC curve analysis, etc.
- `cross_validation.R`: Contains code for performing cross-validation, such as 10-fold cross-validation.

## File Descriptions

### `main.R`

- Orchestrates the execution of the project.
- Calls other files and tasks.

### `data_import_cleaning.R`

- Imports data from a CSV file or from the Kaggle API.
- Cleans and prepares data for analysis by handling missing values, casting data types, removing duplicates, etc.

### `eda.R`

- Conducts exploratory data analysis (EDA) by generating visualizations (histograms, boxplots, scatter plots, correlation matrices) and calculating descriptive statistics.

### `decision_tree_model.R`

- Implements and evaluates the decision tree model for predicting water quality.
- Includes model training, evaluation, and visualization of the decision tree.

### `svm_model.R`

- Implements and evaluates the support vector machine (SVM) model for water quality prediction.
- Includes model training, evaluation, and tuning hyperparameters.

### `naive_bayes_model.R`

- Implements and evaluates the Naive Bayes model for water quality prediction.
- Includes model training, evaluation, and performance analysis.

### `performance_evaluation.R`

- Evaluates the performance of machine learning models by calculating metrics such as accuracy, creating confusion matrices, and analyzing ROC curves.

### `cross_validation.R`

- Performs cross-validation to assess model performance using techniques like 10-fold cross-validation.
- Evaluates models' generalization capabilities and provides insights into model stability.

## Dependencies

The project depends on the following R packages, which must be installed before running the code:

- `plyr`
- `jsonlite`
- `httr`
- `caret`
- `reshape2`
- `FactoMineR`
- `factoextra`
- `rpart`
- `rattle`
- `rpart.plot`
- `RColorBrewer`
- `e1071`
- `naivebayes`
- `ROCR`
- `pROC`
- `kernlab`

## Contributors

- [Davide  Grandesso](https://github.com/dadegrande99)
- [Fabio Marini](https://github.com/fabbio00)

## License

This project is licensed under the [MIT License](https://choosealicense.com/licenses/mit/) - see the [LICENSE](LICENSE) file for details.
