##---------------------------------------------------------------------------
## Exploratory Analysis - Course Project 
## Plot 6
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
NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))
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
## Question 6
##
## Compare emissions from motor vehicle sources in Baltimore City with 
## emissions from motor vehicle sources in Los Angeles County, California 
## (fips == "06037"). Which city has seen greater changes over time in motor 
## vehicle emissions?
##---------------------------------------------------------------------------

# Baltimore City, Maryland
# Los Angeles County, California
# Mary.onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
# CA.onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')
Mary.onroad.em <- summarise(group_by(filter(NEI, fips == "24510"& type == 'ON-ROAD'), year), sumEmissions=sum(Emissions))
CA.onroad.em <- summarise(group_by(filter(NEI, fips == "06037"& type == 'ON-ROAD'), year), sumEmissions=sum(Emissions))

# merge them
Mary.onroad.em$County <- "Baltimore City, MD"
CA.onroad.em$County <- "Los Angeles County, CA"
both.emissions <- rbind(Mary.onroad.em, CA.onroad.em)


plot6 <- ggplot(both.emissions, aes(x = year, y = sumEmissions, fill = County, label = round(sumEmissions, 2))) +
                geom_bar(stat = "identity") +
                facet_grid(. ~ County) +
                ylab(expression('PM'[2.5])) + 
                xlab('Year') + 
                theme(legend.position='none') +
                ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') +
                geom_text(aes(label=round(sumEmissions,0), size=1, hjust=0.5, vjust=-1))


print(plot6)
ggsave("./020_figures/plot6.png",  width=12.5*1.5, height=8.25*1.5, dpi=64) 

