# Upload Data

# Path to file
file_loc <- "https://www.kaggle.com/c/9840/download-all"

# Download data
download.file(file_loc, paste0(getwd(),"/data"))

# Unzip file
zipf <- paste0(getwd(),"/data/","all.zip")
outdir <- paste0(getwd(),"/data")

unzip(zipf,exdir=outdir)
