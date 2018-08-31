# Question:
# Have total emissions from PM2.5 decreased in the United States from 
# 1999 to 2008? Using the base plotting system, make a plot showing the total 
# PM2.5 emission from all sources for each of the years 1999, 2002, 2005, 
# and 2008.

library(ggplot2)
library(dplyr)

#Unzip source file
print("Extracting source files from zip file ...")
unzip("exdata%2Fdata%2FNEI_data.zip")

#Load data from source files
print("Loading source files into R ...")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Sum total emissions for each year
print("Summing total emission per year ...")
totals <- NEI %>% select(year, Emissions) %>% 
                  group_by(year) %>% 
                  summarize(total_emissions =  sum(Emissions))

#Divide each total emissions by 1,000 for cleaner plotting lablels
totals$total_emissions_thousands <- totals$total_emissions / 1000

#Plot a line graph
print("Plotting line graph  ...")
png(file = "plot1.png")
qplot(year, total_emissions_thousands, 
            data = totals, 
            geom  = c("line"), 
            ylab = "Total PM25 Emissions", 
            xlab = "Year", 
            main = "Total PM25 Emissions by Year (in thousands)")
           
dev.off()
print("Plotting complete.")

