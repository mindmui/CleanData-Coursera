# Week 3 - Subsetting

# a quick review:
  set.seed(12345)
  x <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
  x<- x[sample(1:5),]; x$var2[c(1,3)] = NA
  # 
    x[x$var1<=3,] # subsetting where var1 is less than 3
  # Dealing with missing values
    x[which(x$var2 > 8),]
  # sort
    sort(x$var1, decreasing =TRUE, na.last = TRUE)
  # ordering
    x[order(x$var1),] # reorder the rows such that variable 1 is in increasing value
  # ordering with plyr
    install.packages("plyr")
    library(plyr)
    arrange(x,var1) # is the same as the above command
    arrange(x,desc(var1)) # wrap with desc for descending order
    
  # adding rows and columns
    x$var4 <- rnorm(5)
    x # added varialbe
    y <- cbind(x,rnorm(5)) # bind to the right of x
    y 
  
# Summarizing data
  # Setting up
    setwd("/Users/Mind/Desktop/Cleandata-Coursera")
    if(!file.exists("./data")){
      dir.create("data")
    }
    fileUrl <- "http://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
    download.file(fileUrl,destfile="./data/restaurants.csv",method="curl")
    restData <- read.csv("./data/restaurants.csv")
  # look at a bit of data
    head(restData)
    tail(restData, n=2) # shows bottom 2
    summary(restData) # for qualitative shows the count
    # for quantitative shows the distribution
    str(restData)
    quantile(restData$councilDistrict,na.rm=TRUE)
    quantile(restData$councilDistrict,probs = c(0.5,0.75,0.9)) # different percentile
  # make table
    table(restData$zipCode,useNA = "ifany") # shows the missing value (if any)
  
  # check for missing values
    sum(is.na(restData$councilDistrict))
    any(restData$zipCode > 0)
    all(restData$zipCode > 0)
    