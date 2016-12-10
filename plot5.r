##---------------------------------------------------------------------------
## Exploratory Analysis - Course Project 
## Plot 5
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
## Question 5
##
## How have emissions from motor vehicle sources changed from 1999-2008 
## in Baltimore City?
##---------------------------------------------------------------------------


# Road related subset
Mary.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')
Mary.em <- summarise(group_by(Mary.onroad, year), sumEmissions=sum(Emissions))

Mary.em$year <- factor(Mary.em$year, levels=c('1999', '2002', '2005', '2008'))

plot5 <- ggplot(data = Mary.em, aes(x = year, y = sumEmissions)) + 
                geom_bar(stat="identity") + 
                guides(fill = FALSE) + 
                ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + 
                ylab(expression('PM'[2.5])) + 
                xlab('Year') + 
                theme(legend.position = 'none') + 
                geom_text(aes(label = round(sumEmissions, 0), size = 1, hjust = 0.5, vjust = 2))

print(plot5)
ggsave("./020_figures/plot5.png",  width=12.5*1.5, height=8.25*1.5, dpi=64) 

