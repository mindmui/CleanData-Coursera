# Week 1 - Getting and Cleaning Data
 
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
  # Loading flat files - read.table()
    # main funtion for reading data into R
    # Reads the data into RAM, big data can cause problem
      cameraData <- read.table("./data/filename.csv", sep=",", header = TRUE)
      # if the data contains the columns names
      # alternatively, use read.csv()
      # More important parameters:
        # na.strings - set the character that represents missing value (e.g. 999)
        # skip - number of lines to skip before starting to read
        # nrows - how many rows to read of the file
        # quote = "" often resolves ` or " issues

# Reading Excel files
  # Most widely used format ---> spreadsheets
  # requires xlsx package **
  library(xlsx)
  cameraData  <- read.xlsx("./file.xlsx",sheetIndex = 1,header=TRUE)
  # you can read specific rows and columns by passing colIndex and rowIndex parameters
    # (reading subset of the excel file)
  # Further notes:
    # read.xlsx2 is much faster
    # write.xlsx will write out
    # in general, it is advised to store your data in .csv as they are easier to distribute
  
# Reading XML 
  # extensible markup language
  # frequently used to store structured data
  # Extracting XML is the basis for most web scraping
    # tags <section> </section> or <br/>
    # elements are specific examples of tags
    # attribute are components of the label
  library(XML)
  fileUrl <- "http://www.w3schools.com/xml/simple.xml"
  doc <- xmlTreeParse(fileUrl,useInternal=TRUE) # for html, use htmlTreeParse
  rootNode <- xmlRoot(doc)
  xmlName(rootNode)
    # access parts of XML, just like how you access a list
  # xpathSApply for web scraping **
  
# Reading JSON
  # Javascript Object Notation
  # Lightweight data storage
  library(jsonlite)
  jsonData <- fromJSON("url")
  names(jsonData) # get all 
  names(jsonData$owner) # just like accessing column of a data frame
  # Writing data frames to JSON
    myjson <- toJSON(irisframe, pretty=TRUE)
  # convert JSON back to data frame
    iris2 <- fromJSON(myjson)

# data.table
  # inherits from data.frame()
  #  Written in C, so it is much faster!
  library(data.table)
  DT = data.table(x=rnorm(9),y=rep(c("a","b"))) #just like what you do with data.frame()
  # Subsetting data talbe
    # is the same as how you do for data frame
    # HOWEVER! subsetting columns are different
  # Adding new columns
    DT[,w:=z^2] # to generate new var, w as a square of z
  # Multiple operations:
    DT[,m:={tmp<-(x+z); log2(tmp+5)}] # note that in R, {} is to put commmands together
  # Special Variables
    .N # to count the number of time (the item appears)
  # Keys ** very handy
    setkey(DT,x) # set x to be the key for DT
  # Joins 
    merge(DT1,DT2) # merge data table with the same key

    
