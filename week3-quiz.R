## Quiz 3
# Question 1
setwd("/Users/Mind/Desktop/Cleandata-Coursera")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "acs.csv", method = "curl")
acs <- read.csv('acs.csv')
log <- acs$ACR==3 & acs$AGS ==6
which(log)
head(which(log),3)

# Question 2
install.packages("jpeg")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl, destfile = "jeff.jpg", method = "curl")
library(jpeg)
img <- readJPEG('jeff.jpg', native=TRUE)
quantile(img, probs = c(0.3, 0.8) )

# Question 3
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "gdp.csv", method = "curl")
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl2, destfile = "edu.csv", method = "curl")
gdp <- read.csv('gdp.csv', header = F, skip=5, nrows=190) # skip the header
edu <- read.csv('edu.csv')
names(gdp)
names(edu)
mergedat <- merge(gdp, edu, by.x="V1", by.y="CountryCode", all= TRUE)
sum(!is.na(mergedat$V2)) #190
names(mergedat)
# Sort the data and get 13th row
mergedat[order(mergedat$V2,decreasing = TRUE),][13,]

# Question 4
mean(mergedat[mergedat$Income.Group=='High income: OECD',]$V2, na.rm=TRUE)
mean(mergedat[mergedat$Income.Group=='High income: nonOECD',]$V2, na.rm=TRUE)

# Question 5
myq <- c(0.2,0.4,0.6,0.8,1)
q <- quantile(mergedat$V2, myq, na.rm=TRUE)
q1 <- mergedat$V2 <= 38
table(mergedat$Income.Group,q1)
