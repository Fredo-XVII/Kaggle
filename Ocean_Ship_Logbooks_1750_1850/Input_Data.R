getwd()
initial.dir <- getwd()

setwd('C:\\Users\\marqu\\Documents\\Kaggle\\Ocean_Ship_Logbooks_1750_1850\\')

Input.Data <- 'C:\\Users\\marqu\\Documents\\Kaggle\\Ocean_Ship_Logbooks_1750_1850\\Data\\CLIWOC15.csv'
CLIWOC <- read.csv(Input.Data,header = TRUE, sep = ",")

rm(CLIWOC)

setwd("C:/Users/marqu/Documents")

