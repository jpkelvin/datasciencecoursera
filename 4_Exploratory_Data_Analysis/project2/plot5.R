library("data.table")
library("ggplot2")

NEI <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))

# NEI data which corresponds to vehicles
vehiclesSCC <- SCC[grepl("vehicle", SCC.Level.Two, ignore.case=TRUE)
                   , SCC]
vehiclesNEI <- NEI[NEI[, SCC] %in% vehiclesSCC,]

# NEI data to Baltimore's fip
baltimoreVehiclesNEI <- vehiclesNEI[fips=="24510",]

png("plot5.png")

ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity", fill ="red" ,width=0.75) +
  labs(x="year", y=expression("Total Emission")) + 
  labs(title="Motor Vehicle Source Emissions in Baltimore from 1999-2008")

dev.off()