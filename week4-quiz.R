## Quiz 4

# Question 1
setwd("/Users/Mind/Desktop/Cleandata-Coursera")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "acs.csv", method = "curl")
acs <- read.csv('acs.csv')
k <- strsplit(names(acs),"wgtp")
k[123]

# Question 2
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "gdp.csv", method = "curl")
gdp <- read.csv('gdp.csv',skip = 4, nrows=190)
View(gdp)
gdpnum <- gsub(",","",gdp$X.4)
gdpnum <- as.numeric(gdpnum)
mean(gdpnum,na.rm = TRUE)


# Question 3
countryNames <- gdp$X.3
grep("^United",countryNames)

# Question 4
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "gdp.csv", method = "curl")
gdp <- read.csv('gdp.csv',skip = 4, nrows=190)
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl2, destfile = "edu.csv", method = "curl")
edu <- read.csv('edu.csv')
View(edu)
# merge data 
dt <- merge(gdp, edu, all = TRUE, by.x = "X", by.y = "CountryCode")
View(dt)
isEnd <- grepl("[Ff]iscal [Yy]ear end",dt$Special.Notes)
isJune <- grepl("[Jj]une",dt$Special.Notes)
table(isEnd,isJune)

# Question 5
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
View(amzn)
library(lubridate)
amzn$weekday <- weekdays(sampleTimes)
amzn$year <- year(sampleTimes)
table(amzn$year,amzn$weekday)
sum(amzn$year==2012)
