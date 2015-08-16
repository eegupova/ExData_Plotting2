## Download the zip file to your working directory and unzip the file
unzip("exdata-data-NEI_data.zip")

## Read two unzipped rds files into data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make
## a plot answering this question.

## Subset exisiting df to only include data points for Baltimore, MD
NEI_Balt <- NEI[which(NEI$fips == "24510"),]

## Create a new df containing total amounts from PM2.5 per year for Baltimore, MD
NEI_Balt_yr <- aggregate(Emissions ~ year, NEI_Balt, sum)

## Create a line graph to demonstrate changes in total PM2.5 amount year to year
## Save in png file
png("Plot2.png",width=480,height=480)
plot(Emissions/(10^3) ~ year, data = NEI_Balt_yr,
     type="o", col = "darkslategray4", lwd=3,
     main = expression("PM" [2.5]* " Emissions, Baltimore, MD, 1999-2008"),
     xlab = "Year", ylab = expression("PM" [2.5]* " Emissions, '000 tons"))
dev.off()