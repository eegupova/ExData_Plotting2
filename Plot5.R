## Download the zip file to your working directory and unzip the file
unzip("exdata-data-NEI_data.zip")

## Read two unzipped rds files into data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## How have emissions from motor vehicle sources changed from 1999-2008 in
## Baltimore City?

## I will be using IE.Sector variable to identify emissions from motor
## vehicle sources. Such sources include Light and Heavy Duty vehicles
## Therefore, I will only need variables SCC and IE.Sector from SCC data frame
SCC_IESector <- SCC[,c(1,4)]

## Add the names of IE.Sectors corresponding to SC codes by merging data frames
NEI_SCC <- merge(SCC_IESector, NEI, by="SCC")

## Subset new data frame to include only coal combustion-related sources
## in Baltimore, MD
MV <- grep("vehicle", NEI_SCC$EI.Sector, ignore.case = TRUE)
MV_NEI <- NEI_SCC[MV, ]
MV_NEI_Balt <- MV_NEI[which(MV_NEI$fips == "24510"),]

## Aggregate data by year
MV_NEI_Balt_yr <- aggregate(Emissions ~ year, MV_NEI_Balt, sum)

## Create a line graph to demonstrate changes in PM2.5 amount year to year
## Save in png file
library(ggplot2)

png("Plot5.png",width=480,height=480)
ggp <- ggplot(MV_NEI_Balt_yr, aes(x=year, y=Emissions)) +
    theme_bw() + geom_line(size=1.3) +
    geom_point(shape = 16, size = 3) +
    labs(x = "Year", y = expression("PM" [2.5]* " Emissions, tons"),
         title=expression
         ("PM" [2.5]* " Emissions from Motor Vehicles, Baltimore, MD, 1999-2008"))
print(ggp)
dev.off()