## Assignment
## The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. You may use any R package you want to support your analysis.
## You must address the following questions and tasks in your exploratory analysis. For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.
## Question#5
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

## This first line will likely take a few seconds. Be patient!

## Load the required libraries

library(plyr)
library(ggplot2)

## Load data from the current working directory
if (! "NEI" %in% ls()) 
	{ NEI <- readRDS("summarySCC_PM25.rds")}
if (! "SCC" %in% ls()) 	
	{SCC <- readRDS("Source_Classification_Code.rds")}
## Filter NEI data for Baltimore City	
## Lots of discussions on the discussion-forum about the filter condition
## As many people suggested, I'm considering the "ON-ROAD" emission as the motor-vehicle source
NEIBaltimoreCityMotor <- subset(NEI, fips == "24510"  & NEI$type == "ON-ROAD")

## Sum the emission data by year 
totalYearEmission <- ddply(.data = NEIBaltimoreCityMotor, .(year), summarize, "Emission" = sum(Emissions))

minY <- min(totalYearEmission$Emission)
maxY <- max(totalYearEmission$Emission)

## plot the graph
png(filename = "plot5.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))
plot(totalYearEmission, type = "l", xlab = "Year", 
     main = "Total Emissions From Motor Vehicle-related\n Sources from 1999 to 2008\n in Baltimore City by Year", 
	 ylim = c(minY,maxY),
     ylab = expression('Total PM'[2.5]*" Emission"))

dev.off()

 