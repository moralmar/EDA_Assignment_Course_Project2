##---------------------------------------------------------------------------
## Exploratory Analysis - Course Project 
## Plot 1
##
## mmorales 10.12.2016
##---------------------------------------------------------------------------

rm(list = ls()); cat("\014")
setwd("C:/Users/mmora/OneDrive/061 Coursera/spec_DataScience/datascienceCoursera_4EDA/week4/CourseProject")  #for Surface PC

url_data <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
# download.file(url_data, destfile = "./010_data/NEI_data.zip",method = "auto") # not needed to be done every time
# unzipp file
# unzip(zipfile="./010_data/NEI_data.zip",exdir="./010_data")

# Read data files
# read national emissions data
NEI <- readRDS("./010_data/summarySCC_PM25.rds")
# str(NEI)
# dim(NEI)
# head(NEI)

SCC <- readRDS("./010_data/Source_Classification_Code.rds")
# str(SCC)
# dim(SCC)
# head(SCC)


require(dplyr)

##---------------------------------------------------------------------------
## Question 1
##
## Have total emissions from PM2.5 decreased in the United States from 
## 1999 to 2008? Using the base plotting system, make a plot showing the 
## total PM2.5 emission from all sources for each of the years 1999, 2002, 
## 2005, and 2008.
##---------------------------------------------------------------------------

total.em <- summarise(group_by(NEI, year), sumEmissions = sum(Emissions))
# str(total.em)   # we have the 4 years here

png(filename='./020_figures/plot1.png') # open graphical device for saving

colo <- c("red3", "green3", "blue3", "yellow3")
plot1 <- barplot(total.em$sumEmissions/1000
                 , names = total.em$year
                 , xlab = "year"
                 , ylab = "total PM'[2.5]*' emission in kilotons"
                 , ylim = c(0,8000)
                 , main=expression('Total PM'[2.5]*' emissions at various years in kilotons')
                 , col = colo
                 )
## Add text at top of bars
text(x = plot1
     , y = round(total.em$sumEmissions/1000,2)
     , label = round(total.em$sumEmissions/1000,2)
     , pos = 3
     , cex = 0.8
     , col = "black"
     )


dev.off() # plot finished. close graphical device



