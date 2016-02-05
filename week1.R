# Week 1 -Getting and Cleaning Data
 
# The goal of the course:
# Raw data* -> Processing script* -> Tidy data* -> Data Analysis -> Data Communication
# Because real data is not clean!


# Raw and Processed Dara
  # Data are values of qualitative or quantitative variables, belonging to a set of items
  # Raw data
    # the original source of data
    # often hard to use for data analyses
  # Processed data
    # Data that's ready for analysis
    # All processing steps (merging, subsetting, transforming, ...) 
    # should be recorded. Be explicit!
  
  
# Downloading files
  # Setting directories
    getwd()
    setwd("/Users/Mind/Desktop/Cleandata-Coursera")
    # to go up one directory, use setwd("../") 
  # Checking for and creating directories
    file.exists("directoryName") # check if directory exists
    dir.create("directoryName") # create a directory if doesn't exist
    # example:
      if(!file.exists("data")){
        dir.create("data")
      }
  # Getting data from the internet
    fileUrl <- "something"
    download.file(fileUrl,destfile = "./data/cameras.csv", method = "curl")
    list.files("./data")
    dateDownloaded <- date() # a good practice to show which day you downlaoded the file
    # Remarks: if the url is 'https', on a Mac, you need to set the method = "curl"
    
  # Reading local flat files
    
    
