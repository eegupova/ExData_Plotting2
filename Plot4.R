## Download the zip file to your working directory and unzip the file
unzip("exdata-data-NEI_data.zip")

## Read two unzipped rds files into data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Across the United States, how have emissions from coal combustion-related
## sources changed from 1999-2008?

## I will be using IE.Sector variable to identify emissions from coal
## combustion-related sources. Therefore, I will only need variables SCC and
## IE.Sector from SCC data frame
SCC_IESector <- SCC[,c(1,4)]

## Add the names of IE.Sectors corresponding to SC codes by merging data frames
NEI_SCC <- merge(SCC_IESector, NEI, by="SCC")

## Subset new data frame to include only coal combustion-related sources
CC <- grep("comb.*coal|coal.*comb", NEI_SCC$EI.Sector, ignore.case = TRUE)
CC_NEI <- NEI_SCC[CC, ]

## Aggregate data by year
CC_NEI_yr <- aggregate(Emissions ~ year, CC_NEI, sum)

## Create a line graph to demonstrate changes in total PM2.5 amount year to year
## Save in png file
library(ggplot2)

png("Plot4.png",width=480,height=480)
ggp <- ggplot(CC_NEI_yr, aes(x=year, y=Emissions/1000)) +
    theme_bw() + geom_line(size=1.3) +
    geom_point(shape = 16, size = 3) +
    labs(x = "Year", y = expression("PM" [2.5]* " Emissions, '000 tons"),
         title=expression
         ("PM" [2.5]* " Emissions from Coal Combustion-Related Sources, 1999-2008"))
print(ggp)
dev.off()