# Begin Analysis
library('rpart')
library('tree')

# Add column with total number of ingredients
sapply(train, function(x) length(unique(x)))

ingredients <- train$ingredients[1:100]

ingr <- NULL

warnings()

testing <- 
        for (i in seq_along(ingredients)) {
                dis <- unique(ingredients[i])

} 
