library(data.table)

"
Creates a CSV file with all indicator names and their corresponding codes.
"

setwd('/home/vcolano/Documents/worldDev/data')

indicators = fread('Indicators.csv')

indicatorNames = unique(subset(indicators, select=c("IndicatorName", "IndicatorCode")))
write.csv(indicatorNames, file = "indicatorNames.csv")

