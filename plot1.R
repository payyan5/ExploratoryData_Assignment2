## Assignment
## The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. You may use any R package you want to support your analysis.
## You must address the following questions and tasks in your exploratory analysis. For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.
## Question#1
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

## This first line will likely take a few seconds. Be patient!


## Load the required libraries

library(plyr)
library(ggplot2)

## Load data from the current working directory
if (! "NEI" %in% ls()) 
	{ NEI <- readRDS("summarySCC_PM25.rds")}
if (! "SCC" %in% ls()) 	
	{SCC <- readRDS("Source_Classification_Code.rds")}
## Sum the data by year
totalYearwiseEmission <- ddply(.data = NEI, .(year), summarize, "Emission" = sum(Emissions))
minY <- min(totalYearwiseEmission$Emission)
maxY <- max(totalYearwiseEmission$Emission)

## plot the graph
png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

plot(totalYearwiseEmission$year, totalYearwiseEmission$Emission, type="l",
     xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
	 ylim=c(minY,maxY),
     main=expression("Total US" ~ PM[2.5] ~ "Emissions by Year"))
dev.off()

