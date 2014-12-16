## Assignment
## The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. You may use any R package you want to support your analysis.
## You must address the following questions and tasks in your exploratory analysis. For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.
## Question#4
## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
## This first line will likely take a few seconds. Be patient!


## Load the required libraries

library(plyr)
library(ggplot2)

## Load data from the current working directory
if (! "NEI" %in% ls()) 
	{ NEI <- readRDS("summarySCC_PM25.rds")}
if (! "SCC" %in% ls()) 	
	{SCC <- readRDS("Source_Classification_Code.rds")}
## Filter SCC data for coal combustion-related sources
SCCCoalCombustion <- subset(SCC, grepl("Comb", Short.Name, ignore.case = TRUE) & grepl("Coal", Short.Name, ignore.case = TRUE))
## Filter NEI data for coal combustion-related sources
NEICoalCombustion <- subset(NEI, NEI$SCC %in% SCCCoalCombustion$SCC)
## Sum the emission data by year
totalYearEmission <- ddply(.data = NEICoalCombustion, .(year), summarize, "Emission" = sum(Emissions))
minY <- min(totalYearEmission$Emission)
maxY <- max(totalYearEmission$Emission)

## plot the graph 
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))
	
	
plot(totalYearEmission$year, totalYearEmission$Emission, type="l",
     xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
	 ylim=c(minY,maxY),
     main=expression("Total " ~ PM[2.5] ~ "Emissions from Coal combustion-related sources by Year"))
dev.off()

