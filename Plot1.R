## Download the zip file to your working directory and unzip the file
unzip("exdata-data-NEI_data.zip")

## Read two unzipped rds files into data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Have total emissions from PM2.5 decreased in the United States from 1999 to
## 2008? Using the base plotting system, make a plot showing the total PM2.5
## emission from all sources for each of the years 1999, 2002, 2005, and 2008.

## Create a new df containing total amounts from PM2.5 per year
NEI_yr <- aggregate(Emissions ~ year, NEI, sum)

## Create a line graph to demonstrate changes in total PM2.5 amount year to year
## Save in png file
png("Plot1.png",width=480,height=480)
plot(Emissions/(10^6) ~ year, data = NEI_yr,
     type="o", col = "darkslategray4", lwd=3,
     main = expression("Total PM" [2.5]* " Emissions, US, 1999-2008)"),
     xlab = "Year", ylab = expression("PM" [2.5]* " Emissions, MM tons"))
dev.off()