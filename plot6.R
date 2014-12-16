## Assignment
## The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. You may use any R package you want to support your analysis.
## You must address the following questions and tasks in your exploratory analysis. For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.
## Question#6
## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
## This first line will likely take a few seconds. Be patient!

## Load the required libraries

library(plyr)
library(ggplot2)

## Load data from current working directory
if (! "NEI" %in% ls()) 
	{ NEI <- readRDS("summarySCC_PM25.rds")}
if (! "SCC" %in% ls()) 	
	{SCC <- readRDS("Source_Classification_Code.rds")}
## Filter NEI data for Baltimore City and Los Angeles County	
## Lots of discussions on the discussion-forum about the filter condition
## As many people suggested, I'm considering the "ON-ROAD" emission as the motor-vehicle source
NEILosAngelesBaltimoreCityMotor <- subset(NEI, (fips == "24510" | fips == "06037") & NEI$type == "ON-ROAD")

## Sum the emission data by year and location
totalYearEmission <- ddply(.data = NEILosAngelesBaltimoreCityMotor, .(year, fips), summarize, "Emission" = sum(Emissions))

## plot the graph
png(filename = "plot6.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))
qplot(year, Emission, data=totalYearEmission, color=fips, geom="line") +
	ggtitle(expression("PM 2.5 Emissions from Motor Vehicle-related Sources\n by Year for Baltimore city and Los Angeles County")) +
	xlab("Year") +
	ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)")) + 
	scale_colour_discrete(name = "Group", label = c("Los Angeles","Baltimore"))
dev.off()

  
  
  
  