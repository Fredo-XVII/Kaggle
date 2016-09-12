#Titanic_DataCamp.R

# Assign the training set
url_train <- "http://s3.amazonaws.com/assets.datacamp.com/course/Kaggle/train.csv"
train <- read.csv(url_train)

# Assign the testing set
url_test <- "http://s3.amazonaws.com/assets.datacamp.com/course/Kaggle/test.csv"
test <-read.csv(url_test)

# Make sure to have a look at your training and testing set
head(train)
head(test)

str(train)
str(test)

# Rose vs Jack , or Female vs Male
table(train$Survived)
prop.table(table(train$Survived))

table(train$Sex)
prop.table(table(train$Sex))

table(train$Survived,train$Sex)
prop.table(table(train$Survived,train$Sex),1)
prop.table(table(train$Survived,train$Sex),2)

table(train$Survived,train$Embarked,train$Pclass)
table(train$Survived,train$Embarked,train$Pclass,train$Sex )
prop.table(table(train$Survived,train$Sex,train$Embarked),1)
prop.table(table(train$Survived,train$Sex,train$Embarked),2)
prop.table(table(train$Survived,train$Embarked,train$Pclass,train$Sex ),1)
prop.table(table(train$Survived,train$Embarked,train$Pclass,train$Sex ),2)

# Does age play a role/
train$child <- NA
train$child[train$Age < 18] <- 1
train$child[train$Age >= 18] <- 0     

table(train$child,train$Survived)
prop.table(table(train$child,train$Survived),1)

#Making your first predictions
test_one <- test
test_one$Survived[test_one$Sex == 'male'] <- 0
test_one$Survived[test_one$Sex == 'female'] <- 1

#intro to decision trees
library('rpart')
# Your train and test set are still loaded in
str(train)
str(test)

# Build the decision tree
my_tree_two <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked ,
                     data = train , method = "class")

# Visualize the decision tree using plot() and text()
plot(my_tree_two)
text(my_tree_two)

# Load in the packages to create a fancified version of your tree
library(rattle)
library(rpart.plot)
library(RColorBrewer)

# Time to plot your fancified tree
fancyRpartPlot(my_tree_two)

#Predict and submit to Kaggle
# Your train and test set are still loaded in
str(train)
str(test)

# Make your prediction using the test set
my_prediction <- predict( my_tree_two, test, type = "class")

# Create a data frame with two columns: PassengerId & Survived. Survived contains your predictions
my_solution <- data.frame(PassengerId = test$PassengerId, Survived = my_prediction)

# Check that your data frame has 418 entries
nrow(my_solution)

# Write your solution to a csv file with the name my_solution.csv
write.csv(my_solution, file = "my_solution.csv" , row.names = FALSE)

# Make your prediction using the test set
my_prediction <- predict(my_tree_two, test, type = "class")

# Create a data frame with two columns: PassengerId & Survived. Survived contains your predictions
my_solution <- data.frame(PassengerId = test$PassengerId, Survived = my_prediction)

# Check that your data frame has 418 entries
nrow(my_solution)

# Write your solution to a csv file with the name my_solution.csv
write.csv(my_solution, file = "C:\\Users\\marqu\\Documents\\Kaggle\\Titanic\\Output\\my_solution.csv", row.names = FALSE)



