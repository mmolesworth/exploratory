# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
# plot answering this question.

library(dplyr)

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
                  select(year, Emissions) %>% 
                  group_by(year) %>% 
                  summarize(total_emissions =  sum(Emissions))

#Divide each total emissions by 1,000 for cleaner plotting lablels
totals$total_emissions_thousands <- totals$total_emissions / 1000

#Plot a line graph
print("Plotting line graph  ...")
with(totals, 
     plot(year, total_emissions_thousands, 
          type = "b", 
          main = "Baltimore City (24510) PM25 Emissions by Year (in thousands)", 
          ylab = "Total Emissions", 
          xlab = "Year", 
          cex.main = .85))

#Save to PNG file
print("Saving to PNG file ...")
dev.copy(png, "plot2.png")
dev.off()

print("Plotting complete.")




