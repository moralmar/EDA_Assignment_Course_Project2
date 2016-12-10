##---------------------------------------------------------------------------
## Exploratory Analysis - Course Project 
## Plot 3
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
require(ggplot2)

##---------------------------------------------------------------------------
## Question 3
##
## Of the four types of sources indicated by the type (point, nonpoint, 
## onroad, nonroad) variable, which of these four sources have seen decreases 
## in emissions from 1999-2008 for Baltimore City? Which have seen increases 
## in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot 
## answer this question.
##---------------------------------------------------------------------------

NEI_balti <- subset(NEI, fips == 24510)
NEI_balti$year <- factor(NEI_balti$year, levels=c('1999', '2002', '2005', '2008'))  # !! important !! otherwise, only one boxplot per Type

plot3 <- ggplot(data = NEI_balti, aes(x = year, y = log10(Emissions))) +
                geom_boxplot(aes(fill = type)) +
                stat_boxplot(geom = "errorbar") +
                facet_grid( . ~ type) +
                guides(fill = FALSE) +
                ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) +
                xlab('Year') + 
                ggtitle('Emissions per Type in Baltimore City, Maryland') +
                geom_jitter(alpha = 0.13)

                
print(plot3)
ggsave("./020_figures/plot3.png",  width=12.5*1.5, height=8.25*1.5, dpi=64) 


