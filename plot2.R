##---------------------------------------------------------------------------
## Exploratory Analysis - Course Project 
## Plot 2
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
## Question 2
##
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make 
## a plot answering this question.
##---------------------------------------------------------------------------

#total.em <- summarise(group_by(NEI, year), sumEmissions = sum(Emissions)) # this was for Question 1
balti.em <- summarise(group_by(filter(NEI, fips == "24510"), year), sumBaltiEM = sum(Emissions))
# str(total.em)   # we have the 4 years here

png(filename='./020_figures/plot2.png') # open graphical device for saving

colo <- c("red3", "green3", "blue3", "yellow3")
plot2 <- barplot(balti.em$sumBaltiEM/1000
                 , names = balti.em$year
                 , xlab = "year"
                 , ylab = "total PM'[2.5]*' emission in kilotons"
                 , ylim = c(0,4)
                 , main = expression('Total PM'[2.5]*' emissions for Baltimore City Maryland at various years in kilotons')
                 , col = colo
                 )
## Add text at top of bars
text(x = plot2
     , y = round(balti.em$sumBaltiEM/1000,2)
     , label = round(balti.em$sumBaltiEM/1000,2)
     , pos = 3
     , cex = 0.8
     , col = "black"
     )


dev.off() # plot finished. close graphical device



