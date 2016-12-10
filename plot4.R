##---------------------------------------------------------------------------
## Exploratory Analysis - Course Project 
## Plot 4
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
## Question 4
##
## Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999-2008?
##---------------------------------------------------------------------------

# Coal combustion related sources
# grepl: Pattern matching and replacement
SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]

# merge both data sets according to SCC-number
mrg <- merge(x = NEI, y = SCC.coal, by = 'SCC')  # 53400 rows
mrg.sum <- summarise(group_by(mrg, year), Emissions=sum(Emissions))

plot4 <- ggplot(data = mrg.sum, aes(x = year, y = Emissions / 1000)) +
                geom_line(aes(group = 1, col = Emissions)) +
                geom_point(aes(size = 2, col = Emissions)) + 
                ggtitle(expression('Total Emissions of PM'[2.5])) +
                ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) + 
                geom_text(aes(label = round(Emissions / 1000, digits = 2), size = 2, hjust = 1.5, vjust = 1.5)) + 
                theme(legend.position = 'none') +
                scale_color_gradient(low = 'black', high = 'red')

print(plot4)
ggsave("./020_figures/plot4.png",  width=12.5*1.5, height=8.25*1.5, dpi=64) 

