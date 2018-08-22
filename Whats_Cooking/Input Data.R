source("C:\\Users\\Z001C9V\\Documents\\R\\R_startup.r")

library('rjson')
library('jsonlite')

# Grab data from json file
train <- fromJSON(txt = (file = "C:\\Users\\Z001C9V\\Documents\\R\\Kaggle\\Whats Cooking\\Data\\train.json")
                 , simplifyDataFrame = TRUE) 


         

