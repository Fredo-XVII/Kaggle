# Assign the training set
url_train <- "http://s3.amazonaws.com/assets.datacamp.com/course/Kaggle/train.csv" 
train <- read.csv(url_train)

# Assign the testing set
url_test <- "http://s3.amazonaws.com/assets.datacamp.com/course/Kaggle/test.csv"
test <-read.csv(url_test)
        
# Make sure to have a look at your training and testing set
head(train)
print(test)

str(train)
str(test)

### Rose vs Jack , or Female vs Male
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

### Does age play a role/
train$child <- NA
train$child[train$Age < 18] <- 1
train$child[train$Age >= 18] <- 0      

table(train$child,train$Survived)
prop.table(table(train$child,train$Survived),1)

### Making your first predictions
test_one <- test
test_one$Survived[test_one$Sex == 'male'] <- 0
test_one$Survived[test_one$Sex == 'female'] <- 1

# intro to decision trees
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

###Predict and submit to Kaggle
# Your train and test set are still loaded in
str(train)
str(test)

# Make your prediction using the test set
my_prediction <- predict(my_tree_two,test, type = "class")

# Create a data frame with two columns: PassengerId & Survived. Survived contains your predictions
my_solution <- data.frame(PassengerId = test$PassengerId, Survived = my_prediction)

# Check that your data frame has 418 entries
nrow(my_solution)


# Write your solution to a csv file with the name my_solution.csv
write.csv(my_solution, file = "my_solution.csv" , row.names = FALSE )


### Overfitting, the iceberg of decision trees
# Your train and test set are still loaded in
str(train)
str(test)

# Create a new decision tree my_tree_three
my_tree_three <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, 
                       data=train, method="class", control=rpart.control(minsplit=50, cp=0))
                                              
fancyRpartPlot(my_tree_three)

### Re-engineering our Titanic data set
# Your train and test set are still loaded in
str(train)
str(test)

# create a new train set with the new variable
train_two <- train
train_two$family_size <- train_two$SibSp + train_two$Parch + 1

# Create a new decision tree my_tree_three
my_tree_four <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + family_size, 
                      data=train_two, method="class", control=rpart.control(minsplit=50, cp=0))

        
### Visualize your new decision tree
fancyRpartPlot(my_tree_four)

### Passenger Title and survival rate
# Create train_new by pulling the Mr./Mrs. from the Name of the Passenger. (ME)
        

# train_new and test_new are available in the workspace        

str(train_new)
str(test_new)

# Create a new model `my_tree_five`
my_tree_five <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title ,
                      data=train_new, method="class")

# Visualize your new decision tree
fancyRpartPlot(my_tree_five)

# Make your prediction using `my_tree_five` and `test_new`
my_prediction <- predict(my_tree_five,test_new, type = "class") 
        
# Create a data frame with two columns: PassengerId & Survived. Survived contains your predictions
my_solution <- data.frame(PassengerId = test_new$PassengerId, Survived = my_prediction)
        
# Write your solution away to a csv file with the name my_solution.csv
write.csv(my_solution, file = "my_solution.csv" , row.names = FALSE )

### What is a Random Forest
# All data, both training and test set
all_data

# Passenger on row 62 and 830 do not have a value for embarkment. 
# Since many passengers embarked at Southampton, we give them the value S.
# We code all embarkment codes as factors.
all_data$Embarked[c(62,830)] = "S"
all_data$Embarked <- factor(combi$Embarked)

# Passenger on row 1044 has an NA Fare value. Let's replace it with the median fare value.
all_data$Fare[1044] <- median(combi$Fare, na.rm=TRUE)

# How to fill in missing Age values?
# We make a prediction of a passengers Age using the other variables and a decision tree model. 
# This time you give method="anova" since you are predicting a continuous variable.
predicted_age <- rpart(Age ~ Pclass + Sex + SibSp + Parch + Fare + Embarked + Title + family_size,
                       data=all_data[!is.na(all_data$Age),], method="anova")
all_data$Age[is.na(all_data$Age)] <- predict(predicted_age, all_data[is.na(all_data$Age),])

# Split the data back into a train set and a test set
train <- all_data[1:891,]
test <- all_data[892:1309,]

### A Random Forest analysis in R
# train and test are available in the workspace
str(train)
str(test)

# Load in the package
library(randomForest)

# Train set and test set
str(train)
str(test)

# Set seed for reproducibility
set.seed(111)

# Apply the Random Forest Algorithm
my_forest <- randomForest(as.factor(Survived) ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title ,
                data = train , importance = TRUE , ntree = 1000  )

# Make your prediction using the test set
my_prediction <- predict(my_forest, test)

# Create a data frame with two columns: PassengerId & Survived. Survived contains your predictions
my_solution <- data.frame(PassengerId = test$PassengerId , Survived = my_prediction)
        
# Write your solution away to a csv file with the name my_solution.csv
write.csv(my_solution, file = "my_solution_forest.csv" , row.name = FALSE)

### Important variables
varImpPlot(my_forest)

### My code for submission 
# Logit
glm(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, 
    data = train , family = binomial(link="logit"))

summary(train)
sapply(train,sd)
xtabs(~Survived + Sex + Embarked, data = train)# like the command table
