## Quiz 1
# Q1 
  myurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  download.file(myurl, destfile = "./data/q1.csv")
  q1data <- read.csv("./data/q1.csv")
  head(q1data$VAL)
  q1data$VAL <- as.numeric(q1data$VAL)
  sum(q1data$VAL == 24, na.rm = TRUE)
# Q2
  # Tidy data has one variable per column.
# Q3
  require(xlsx)
  myurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
  download.file(myurl, destfile = "./data/q3.xlsx")
  dat <- read.xlsx("./data/q3.xlsx", sheetIndex = 1, colIndex = 7:15, rowIndex = 18:23)
  sum(dat$Zip*dat$Ext,na.rm=T)
# Q4
  require(XML)
  fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
  doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
  rootNode <- xmlRoot(doc)
  sum(xpathSApply(rootNode, "//zipcode", xmlValue) == "21231")
# Q5
  require(data.table)
  geturl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
  download.file(myurl, destfile = "./data/q5.csv")
  DT <- fread("./data/q5.csv", )

  