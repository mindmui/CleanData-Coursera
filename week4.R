## Week 4 
# Editing text variables
  names(cameraData)
  # make the column names to lower cases / 
    tolower(names(cameraData)) # toupper also exists
  # fixing character vectors
    strsplit(names(cameraData),"\\.") #split on "."
  # Nice and clean variable name
    testName <- "this_is_a_test"
    sub("_","",testName) #only replace the first one
    # if you want to replace all use:
    gsub("_",",testName")
  
  # Search string
    grep("Alameda",cameraData$intersection) 
    # give the location where the Alameda appears
    grepl() # will return the logical instead --> you can use this for subsetting
    # to check if a particular string appears in the data frame
    length(grep("myvalue",cameraData$intersection))
      # if this is zero --> doesn't appear at all
  
  # Useful string functions
    library(stringr)
    nchar("numberofthisstring")
    substr("Mind Mui",1,4) # pick from 1 to 4
    # paste things together without any spaces:
    paste0("Mind","Mui")
    str_trim("Mind     ") #to remove white spaces
    
# Regular expressions -- to be worked with grep, grepl, sub, gsub
  # allows us to search for strings more extensively
  # Definition -- Literals: match exact letters
  
  # Metacharacters:
    ^ # represents the starting of the line
    $ # represents the end of the line
    # Character classes with [] , for example
      [Bb][Uu][Ss][Hh] # will match both BUSH, Bush, BUsh, etc..
    # specify range of characters:
    ^[0-9][a-zA-Z] # begining of the line, number from 0 to 9, followed by a letter (any)
    # specify NOT in the indicated class
      # for example
        [^.]$ # look for line that doesnt end with a period (.)
    # Using |, as "or" to combine two expressions
      flood|fire
        # will match line with floor OR fire
      ^[Gg]ood|[Bb]ad # the beginning of the line "Good" or anywhere in the line "Bad"
    # Using (and),
      ^([Gg]ood|[Bb]ad) # Good or Bad MUST be beginning of the line
    # Using ?, indicating that the expression is optional
      [Gg]eorge( [Ww]\.)? [Bb]ush # not required W to be in the middle of his name
          # Note: \. is to indicate that it's a period "." not a meta character
    # More metacharacters:
      # * means "any number, including none"
      # + means "at least one of the item"
      [0-9]+ (.*)[0-9]+ # at least one number followed by any and at least one number again
      # {m,n}
      # \1 -- for repetition
      # see Mark Hansen for more details

# Working with dates
  d1 <- date()
  d1 
  class(d1) #character
  d2 <- Sys.Date()
  class(d2) #date
  # what can we do is to reformat them:
  format(d2, "%a %b %d")
  # %d for date (in number)
  # %a for day (Monday)
  # %b for month
  weekdays(d2)
  julian(d2) #number of days have been occured
  
  # Easier with dates using a package
  library(lubridate); 
  ymd("20140108") 
  # mdy() will also work!
  # including dealing with times
    ymd_hms()
  
# Free data resources
    data.un.org
    data.gov
    data.gov.uk
    data.gouv.fr
    data.go.jp
    data.gov/opendatasites # good places to start!
    
    gapminder.org # data abt human development
    asdfree.com # survey data from US
    
    
    
    