## Week 2 - Getting and Cleaning Data

# Reading form MySQL
  # Full notes: http://www.r-bloggers.com/mysql-and-r/

  # install MySQL 
  install.packages("RMySQL")
  
  # Connecting and listing databases
  ucscDb <- dbConnect(MySQL(),user="genome",host="genome-mysql.cse.ucsc.edu")
  result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb);
    # don't forget to disconnect!
  
  # Specific database:
  hg19 <- dbConnect(MySQL(),user="genome",db="hg19", host="genome-mysql.cse.ucsc.edu")
  allTables <- dbListTables(hg19)
  length(allTables) 
  allTables[1:5]
  
  # Get dimensions of a specific table "affyU133Plus2"
  dbListFields(hg19,"affyU133Plus2") # shows all the fields (column names)
  dbGetQuery(hg19,"select count(*) from affyU133Plus2") # shows how many rows we have
  
  # Read from the table
  affyData <- dbReadTable(hg19, "affyU133Plus2") # connecting database and the table
  head(affyData)
  
  # Select a specific subset of the data 
    # as the data might be too big to store in R
  query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
  affyMis <- fetch(query); quantile(affyMis$misMatches)
  # get  0%  25%  50%  75% 100% 
  #       1    1    2    2    3 
  # which is the value between 1 to 3
  affyMisSmall <- fetch(query, n=10); dbClearResult(query);
    # don't forget clear the result from last query
  dim(affyMisSmall) 
  
  
# Reading from HDF5
  # Heirarchical data format
  # hdf5 can be used to optimize reading/writing disc in R
  
  # install packages through bioconductor
  source("http://bioconductor.org/biocLite.R")
  biocLite("rhdf5") # to load the packages
  
  library(rhdf5) # to load the library 
  created = h5createFile("example.h5") # to create hdf5 file
  created 
  # create a group
    created = h5createGroup("example.h5","foo")
    created = h5createGroup("example.h5","baa")
    created = h5createGroup("example.h5","foo/foobaa")
  # list out the h5 group
    h5ls("example.h5")
  # Write to groups
    A = matrix(1:10,nr=5,nc=2)
    h5write(A, "example.h5","foo/A") # write an array to a particular subgroup
    h5ls("example.h5")
  # Reading data
    readA = h5read("example.h5","foo/A") # specify file name that you're reading and the specify the data set or group name

# Reading data from the web
  # Webscraping: is a programatically way of extracting data from the HTML code of websites
  # ways to get data very quickly
    
  # Getting data off webpages - readLines()
  con = url("http://scholar.google.com/")
  htmlCode = readLines(con)
  close(con) # close the connection
  htmlCode
  # Parsing with XML
    library(XML)
    url <- "http://scholar.google.com/"
    html <- htmlTreeParse(url, useInternalNodes = T)
    xpathSApply(html,"//title",xmlValue) # get the title tag
    xpathSApply(html,"//input",xmlValue) # get the input tag
  # GET from the httr package
    library(httr); html2 = GET(url)
    content2 = content(html2,as="text")
    parsedHtml = htmlParse(content2, asText = TRUE)
    xpathSApply(parsedHtml, "//title", xmlValue)
    
  # Accessing websites with passwords:
    pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
    pg1 # status: 401 is that you haven't logged in
    
    pg2 = GET("http://httpbin.org/basic-auth/user/passwd", 
              authenticate("user","passwd"))
  # Using handles
    google = handle("http://www.google.com")
    pg1 = GET (handle = google, path="/")
    
# Reading from APIs
  # API is the application programming interfaces
  # https://apps.twitter.com/app
    
  # Accessing Twitter from R
    myapp = oauth_app("twitter", key="ACglNgEsA9MZRMitJdxlHsEeW", secret="oMdMJYWe24K0neeZXna50LF7M5q9gI8zv9SalVOyCLzpyKx4JI")
    sig = sign_oauth1.0(myapp, token = "76309075-0DvRtEiF2STVDU6dKNqaogCE6DrIaXv90iIVXHb8q" , token_secret = "yIIRzLZvTPwA6GZ6c8DLNApTWOdtn9gEB6P63hw6RFPmS") # the authetication
    homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json",sig)
  # Converting the json object
    json1 = content(homeTL)
    json2 = jsonlite::fromJSON(toJSON(json1)) # create a dataframe correspond to home timeline
    json2[1,1:4]
    
  # for more info:
    # https://dev.twitter.com/rest/public
    
# Reading from other sources
  # search google for more packages to handle data!
  read.dta() ## to read Stata file!
  