source('C:\\Users\\marqu\\Documents\\R\\Base_Packages_Script.R')

system('~\\gss.csv\\gss.csv')

file_loc <- 'C:\\Users\\marqu\\Documents\\Kaggle\\GSS\\gss.csv\\gss.csv'

gss_csv <- read.csv('C:\\Users\\marqu\\Documents\\Kaggle\\GSS\\gss.csv\\gss.csv' , nrows = 1000 )

gss_fread <-fread(file_loc , skip = 1 , nrow = 1000) # , nrows = 1000 , skip = 1)

gss_readr <- read_csv(file_loc, skip = 1 , n_max = 1000)

write.csv(gss_csv , file = 'C:\\Users\\marqu\\Documents\\Kaggle\\GSS\\gss.csv\\gss_1000.csv')

resp_1 <- filter(gss_fread, RESPONDNT.ID.NUMBER == '1.0')

rm(gss_csv)
