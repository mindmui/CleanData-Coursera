# Week 2 - Quiz

# Question 1
library(httr)
require(httpuv)
require(jsonlite)
# 1. Find OAuth settings for github:
oauth_endpoints("github")
# 2. Register an application at https://github.com/settings/applications
myapp <- oauth_app("quiz2",
                   key = "c3a7ebe87e62e83ed843",
                   secret = "8e551054571acb85705fcde7a80ae497e82601e0")
# Use http://localhost:1410 as the callback url
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
stop_for_status(req)
output <- content(req)
df = jsonlite::fromJSON(toJSON(output))
df[df$name=="datasharing",]$created_at

# Question 2
library(data.table)
install.packages("sqldf")
library(sqldf)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
f <- file.path(getwd(), "ss06pid.csv")
download.file(url, f)
acs <- data.table(read.csv(f))
sqldf("select pwgtp1 from acs where AGEP < 50")

# Question 3
dat1 <- unique(acs$AGEP)
dat2 <- sqldf("select distinct AGEP from acs")
dat1 == dat2

# Question 4
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con) # close the connection
htmlCode
nchar(htmlCode[10]) 
nchar(htmlCode[20]) 
nchar(htmlCode[30]) 
nchar(htmlCode[100]) 

# Question 5
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
lines <- readLines(url, n=10)
w <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3)
colNames <- c("filler", "week", "filler", "sstNino12", "filler", "sstaNino12", "filler", "sstNino3", "filler", "sstaNino3", "filler", "sstNino34", "filler", "sstaNino34", "filler", "sstNino4", "filler", "sstaNino4")
d <- read.fwf(url, w, header=FALSE, skip=4, col.names=colNames)
d <- d[, grep("^[^filler]", names(d))]
sum(d[, 4])
