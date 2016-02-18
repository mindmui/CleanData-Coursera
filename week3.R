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
    colSums(is.na(restData)) #none is any
  # values with specific characteristics
    table(restData$zipCode %in% c("21212","21213"))
      # this shows how many row that zipCode is 21212 or 21213
  # subset the data set
    restData[restData$zipCode %in% c("21212","21213"),]
  # Cross tabs
    data(UCBAdmissions)
    DF = as.data.frame(UCBAdmissions)
    xt <- xtabs(Freq ~ Gender + Admit, data=DF ) # take data from DF, Freq is the data value
    # Gender and Admit are the row and column field
  # flat tables:
    ftable()
  # size of the data set
    fakeData = rnorm(1e5)
    object.size(fakeData) # shows the size (in bytes)
    print(object.size(fakeData),units="Mb") # in Megabytes
    
# Create new variables:
  # - missingness indicators
  # - applying transformation
    setwd("/Users/Mind/Desktop/Cleandata-Coursera")
    if(!file.exists("./data")){
      dir.create("data")
    }
    fileUrl <- "http://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
    download.file(fileUrl,destfile="./data/restaurants.csv",method="curl")
    restData <- read.csv("./data/restaurants.csv")
  # create sequences
    s1 <- seq(1,10,by=2) # tell min=1 , max=10, increasing by 2
    s2 <- seq(1,10,length=3)
  # create binary vairable:
    restData$nearMe = restData$neighborhood %in% c("Roland Park","Home land")
    restData$zipWrong = ifelse(restData$zipCode <0,TRUE,FALSE)
    table(restData$zipWrong, restData$zipCode <0)
  # create categorical variables
    restData$zipGroups = cut(restData$zipCode, breaks= quantile(restData$zipCode))
    table(restData$zipGroups)
    table(restData$zipGroups,restData$zipCode)
    ### Easier cutting
    library(Hmisc)
    restData$zipGroups = cut2(restData$zipCode, g=4) # cut into 4 groups according to quantile
    table(restData$zipGroups)
  # create factor variables
    restData$zcf <- factor(restData$zipCode)
    class(restData$zcf)
  # common quantitative transforms:
    x <- 10
    abs(x)
    sqrt(x)
    ceiling(x)
    floor(x)
    round(x, digits = 2) # round to 2 decimal places
    signif(x, digits = 2)
    cos(x) # or sin(x), ... etc.
    log(x) # natural log
    log2(x) # or log10(x)
    exp(x)

# Reshaping the data
  install.packages("reshape2")
  library(reshape2)  
  head(mtcars)
  # melting data frames
  mtcars$carname <- rownames(mtcars)
  # variable melt mpg and hp on the same column   
    carMelt <- melt(mtcars, id=c("carname","gear","cyl"),measure.vars = c("mpg","hp"))
  head(carMelt)
  tail(carMelt)
  
  # Casting data frames
    cylData <- dcast(carMelt,cyl~variable) # cyl is the row, variable is the column
    cylData
    # adding a function   
    cylData <- dcast(carMelt,cyl~variable,mean) 
    cylData
      # resummarizing 
  # Averaging values
    head(InsectSprays)
    tapply(InsectSprays$count, InsectSprays$spray,sum)
      # sum along the count for each spray
    # or a nice way using plyr package
    library(plyr)
    ddply(InsectSprays,.(spray),summarize,sum=sum(count))
  # Creating a new variable - sum
    spraySums <- ddply(InsectSprays,.(spray),summarize,sum=ave(count, FUN=sum))
    spraySums 
    
# dplyr -- working with data frames in R
  # basic assumptions
    # one observation per row
    # each column represents a variable or measure or characteristics
  # dplyr verbs
    # select
    # filter
    # arrange
    # rename
    # mutate
    # summarize
  # deplyr properties:
    # note: first argument is always a data frame
    # the result is a new data frame

# Managing data frames:
  chicago <- readRDS("chicago.rds")
  dim(chicago)
  names(chicago)
  head(select(chicago, city:dptp)) # very handy way to select only city ="dptp"
  head(select(chicago, -(city:dptp))) # very handy way to select all cities except "dptp"
  chicago.f <- filter(chicago, pm25 > 30) # filter data 
  chicago <- arrange(chicago, date) # arrange by the date
  chicago <- rename(chicago, pm25 = pm25tmeans2) # change column name
  # centralised the pm25 using mutate
  chicago <- mutate(chicago, pm25detrend = pm25-mean(pm25)) # transform / create new variable using mutate
  
  chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
  years <- group_by(chicago, year)
  summarise(years, pm25 = mean(pm25, na.rm = TRUE))
  
  # pipeline : %>%
  
  