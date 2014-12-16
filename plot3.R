## Assignment
## The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. You may use any R package you want to support your analysis.
## You must address the following questions and tasks in your exploratory analysis. For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.
## Question#3
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

## This first line will likely take a few seconds. Be patient!


## Load the required libraries

library(plyr)
library(ggplot2)

## Load data from the current working directory
if (! "NEI" %in% ls()) 
	{ NEI <- readRDS("summarySCC_PM25.rds")}
if (! "SCC" %in% ls()) 	
	{SCC <- readRDS("Source_Classification_Code.rds")}
## Filter data for Baltimore City
NEIBaltimore <- subset(NEI,NEI$fips == "24510")	
	
## Sum the emission data by year and type
totalYearTypewiseEmission <- ddply(.data = NEIBaltimore, .(year, type), summarize, "Emission" = sum(Emissions))

## plot the graph using ggplot2
png(filename = "plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))


qplot(year, Emission, data=totalYearTypewiseEmission, color=type, geom="line") +
  ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emissions by Source Type and Year")) +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()
  
  