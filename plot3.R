# Question:
# Of the four types of sources indicated by the type (point, nonpoint, onroad, 
# nonroad) variable, which of these four sources have seen decreases in emissions 
# from 1999–2008 for Baltimore City? Which have seen increases in emissions from 
# 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

library(dplyr)
library(ggplot2)

#Unzip source file
print("Extracting source files from zip file ...")
unzip("exdata%2Fdata%2FNEI_data.zip")

#Load data from source files
print("Loading source files into R ...")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Sum total emissions for each year in Baltimore City (fips == 24510)
print("Summing total emission per year in Baltimore City ...")
totals <- NEI %>% filter(fips == 24510) %>% 
      select(year, type, Emissions) %>% 
      group_by(year, type) %>% 
      summarize(total_emissions =  sum(Emissions))

#Convert 'type' from character to factor
totals$type <- as.factor(totals$type)

Sys.sleep(10)

#Plot line graph for each measurement type
print("Plotting line graph ...")
dev.set(2)
qplot(year, total_emissions, 
            data = totals,
            geom = c("line"),
            col = type,
            ylab = "Total PM25 Emissions", 
            xlab = "Year",
            main = "Baltimore City PM25 Emissions by Year")


#Save to PNG file
print("Saving to PNG file ...")
dev.copy(png, "plot3.png")
dev.off()

print("Plotting complete.")
