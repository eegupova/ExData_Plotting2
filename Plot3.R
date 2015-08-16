## Download the zip file to your working directory and unzip the file
unzip("exdata-data-NEI_data.zip")

## Read two unzipped rds files into data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Of the four types of sources indicated by the type (point, nonpoint, onroad,
## nonroad) variable, which of these four sources have seen decreases in
## emissions from 1999-2008 for Baltimore City? Which have seen increases in
## emissions from 1999-2008? Use the ggplot2 plotting system to make a plot
## answer this question.

## Subset exisiting df to only include data points for Baltimore, MD
NEI_Balt <- NEI[which(NEI$fips == "24510"),]

## Aggregate PM2.5 amounts by year and type
NEI_Balt_yr_type <- aggregate(Emissions ~ year + type, NEI_Balt, sum)

## Create a line graph to demonstrate changes in total PM2.5 amount year to year
## Save in png file
library(ggplot2)

png("Plot3.png",width=480,height=480)
ggp <- ggplot(NEI_Balt_yr_type, aes(x=year, y=Emissions, color=type)) +
    theme_bw() + geom_line(size=1.3) +
    geom_point(shape = 16, size = 3, aes(fill = type)) +
    labs(x = "Year", y = expression("PM" [2.5]* " Emissions, tons"),
         title=expression
         ("PM" [2.5]* " Emissions, Baltimore, MD, 1999-2008, by Source"))
print(ggp)
dev.off()