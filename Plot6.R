## Download the zip file to your working directory and unzip the file
unzip("exdata-data-NEI_data.zip")

## Read two unzipped rds files into data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Compare emissions from motor vehicle sources in Baltimore City with
## emissions from motor vehicle sources in Los Angeles County, California
## (fips == "06037"). Which city has seen greater changes over time in motor
## vehicle emissions?

## I will be using IE.Sector variable to identify emissions from motor
## vehicle sources. Such sources include Light and Heavy Duty vehicles
## Therefore, I will only need variables SCC and IE.Sector from SCC data frame
SCC_IESector <- SCC[,c(1,4)]

## Add the names of IE.Sectors corresponding to SC codes by merging data frames
NEI_SCC <- merge(SCC_IESector, NEI, by="SCC")

## Subset new data frame to include only coal combustion-related sources
## in Baltimore, MD, and Los Angeles County, CA.
MV <- grep("vehicle", NEI_SCC$EI.Sector, ignore.case = TRUE)
MV_NEI <- NEI_SCC[MV, ]
MV_NEI_select <- MV_NEI[which(MV_NEI$fips %in% c("24510", "06037")),]

## Aggregate data by year and location
MV_NEI_select_yr <- aggregate(Emissions ~ year + fips, MV_NEI_select, sum)

fips <- c("06037", "24510")
location <- c("Los Angeles County, CA", "Baltimore, MD")
fips_code <- cbind(fips,location)
MV_NEI_select_yr <- merge(fips_code, MV_NEI_select_yr, by = "fips")

## Create a line graph to demonstrate changes in total PM2.5 amount year to year
## Save in png file
library(ggplot2)

png("Plot6.png",width=630,height=480)
ggp <- ggplot(MV_NEI_select_yr, aes(x=year, y=Emissions, color=location)) +
    theme_bw() + geom_line(size=1.3) +
    geom_point(shape = 16, size = 3, aes(fill = location)) +
    labs(x = "Year", y = expression("PM" [2.5]* " Emissions, tons"),
         title=expression
         ("PM" [2.5]* " Emissions from Motor Vehicles, 1999-2008, by Location"))
print(ggp)
dev.off()