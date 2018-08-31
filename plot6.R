# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?


library(dplyr)
library(ggplot2)

#Unzip source file
print("Extracting source files from zip file ...")
unzip("exdata%2Fdata%2FNEI_data.zip")

#Load data from source files
print("Loading source files into R ...")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Merge NEI coal records with SCC
print("Merging NEI with SCC ...")
NEI_SCC <- merge(NEI, SCC, by.x = "SCC", by.y = "SCC")

#Create dataframe with only motor vehicle sources in Baltimore City (24510)
#Grepping for "On-Road" will return the motor vehicle sources
print("Filtering data for motor vehicle sources ...")

data <-NEI_SCC %>% select(year, EI.Sector, Emissions, fips) %>% 
      filter(fips %in% c("24510", "06037"), grepl("On-Road", EI.Sector )) %>%
      mutate(city = ifelse(fips == "24510", "Balt", "LA")) %>%
      group_by(year, city) %>% 
      summarize(Total_Emissions = sum(Emissions))

#Plot ...
print("Plotting total emissions ...")
dev.set(2)
qplot(year, Total_Emissions, 
      data = data,
      col = city,
      geom = "line", 
      xlab = "Year", 
      ylab = "Total Emissions", 
      main = "Total Motor Vehicle Emissions Baltimore City/Los Angeles 1999-2008")



#Save plot as png
print("Saving PNG file ...")
dev.copy(png, "plot6.png")
dev.off()