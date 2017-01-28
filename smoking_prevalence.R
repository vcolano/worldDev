library(data.table)
library(ggplot2)

# import data
indicators = fread('Indicators.csv')
attach(indicators)

# reduce to the 5 countries with the highest GDP
econ_codes = c("USA", "CHN", "JPN", "DEU", "GBR")
econ_names = c("USA" = "United States","CHN" = "China", "JPN" = "Japan", 
               "DEU" = "Germany", "GBR" = "United Kingdom")
econs = subset(indicators, CountryCode %in% econ_codes)

# reduce to smoking prevalence indicators and bind dataframes into one
smoke_m = subset(subset(econs, Year == "2012"), IndicatorCode == "SH.PRV.SMOK.MA")
smoke_f = subset(subset(econs, Year == "2012"), IndicatorCode == "SH.PRV.SMOK.FE")
smoke_m$Sex = rep("Male", length(smoke_m))
smoke_f$Sex = rep("Female", length(smoke_f))
smoke = rbind(smoke_m, smoke_f)

ggplot(data = smoke, aes(CountryCode, Value)) +
  geom_bar(aes(fill=Sex), stat="identity", position=position_dodge()) +
  scale_x_discrete(limits = econ_codes, labels = econ_names) +
  scale_y_continuous(breaks = seq(0, 80, 5), limits = c(0, 54)) +
  theme_bw(base_size = 12, base_family = "Helvetica")+
  theme_classic() +
  theme(axis.ticks=element_blank()) +
  ggtitle("Smoking prevalence in the world's 5 biggest economies in 2012") +
  ylab("Percent of Adults") +
  xlab("")
